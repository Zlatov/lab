#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

if [[ -z ${1-} ]]
then
  echo "Please supply a subdomain to create a certificate for"
  echo "e.g. mysite.localhost"
  exit 0
fi

if [ -f device.key ]
then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

DOMAIN=$1
COMMON_NAME=${2:-$1}

SUBJECT="/C=RU/ST=MO/L=Moscow/O=Zlatov/CN=$COMMON_NAME"
NUM_OF_DAYS=999

openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT device.key -subj "$SUBJECT" -out device.csr

cat v3.ext | sed s/%%DOMAIN%%/$COMMON_NAME/g > temp_v3.ext

openssl x509 -req -in device.csr -CA ~/rootCA.pem -CAkey ~/rootCA.key -CAcreateserial -out device.crt -days $NUM_OF_DAYS -sha256 -extfile temp_v3.ext

mv device.csr ~/$DOMAIN.csr
cp device.crt ~/$DOMAIN.crt

rm -f device.crt
