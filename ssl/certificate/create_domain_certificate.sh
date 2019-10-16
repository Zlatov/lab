#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

if [[ -z ${1-} ]]
then
  echo "Please supply a subdomain to create a certificate for"
  echo "e.g. mysite.localhost"
  exit 0
fi

rm -rf temp
rm -rf temp_out
mkdir -p temp
mkdir -p temp_out

DOMAIN=$1
COMMON_NAME=${2:-$1}

SUBJECT="/C=RU/ST=MO/L=Moscow/O=Zlatov/CN=$COMMON_NAME"
NUM_OF_DAYS=999


# 1. Закрытый ключ.
openssl genrsa -out temp/rootCA.key 2048

# 2. Корневой сертификат.
openssl req -x509 -new -nodes -key temp/rootCA.key -sha256 -days 1024 -out temp/rootCA.pem

# 3. Создадим файл запроса (.csr - Certificate Signing Request) на основе ключа.
if [ -f temp/rootCA.key ]
then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi
openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT temp/rootCA.key -subj "$SUBJECT" -out temp/device.csr

# 4. Файл настроек
cat v3.ext | sed s/%%DOMAIN%%/$COMMON_NAME/g > temp/temp_v3.ext

openssl x509 -req -in temp/device.csr -CA temp/rootCA.pem -CAkey temp/rootCA.key -CAcreateserial -out temp/device.crt -days $NUM_OF_DAYS -sha256 -extfile temp/temp_v3.ext

cp temp/device.csr temp_out/$DOMAIN.csr
cp temp/device.crt temp_out/$DOMAIN.crt
cp temp/rootCA.key temp_out/$DOMAIN.key
