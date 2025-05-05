```bash
mkdir -p ~/mailserver
cd ~/mailserver
curl -fsSL https://raw.githubusercontent.com/docker-mailserver/docker-mailserver/master/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh config
mkdir -p \
  config \
  mail-data \
  mail-state \
  mail-logs




# docker-compose.yml
services:
  mailserver:
    image: ghcr.io/docker-mailserver/docker-mailserver:latest
    container_name: mail
    hostname: mail
    domainname: zlatov.su
    env_file: mailserver.env
    ports:
      - "25:25"    # SMTP  (explicit TLS => STARTTLS, Authentication is DISABLED => use port 465/587 instead)
      - "143:143"  # IMAP4 (explicit TLS => STARTTLS)
      - "465:465"  # ESMTP (implicit TLS)
      - "587:587"  # ESMTP (explicit TLS => STARTTLS)
      - "993:993"  # IMAP4 (implicit TLS)
    volumes:
      - maildata:/var/mail
      - mailstate:/var/mail-state
      - maillogs:/var/log/mail
      - ./config/:/tmp/docker-mailserver/
      - /etc/letsencrypt:/etc/letsencrypt:ro
    restart: unless-stopped
    stop_grace_period: 1m
    cap_add:
      - NET_ADMIN
      - SYS_PTRACE
    security_opt:
      - no-new-privileges:true

volumes:
  maildata:
  mailstate:
  maillogs:

# mailserver.env
ENABLE_CLAMAV=0
ENABLE_FAIL2BAN=1
ENABLE_POSTGREY=0
SSL_TYPE=letsencrypt
TLS_LEVEL=modern
PERMIT_DOCKER=connected-networks
ENABLE_SPAMASSASSIN=1
ENABLE_SRS=1
ENABLE_MANAGESIEVE=1
ONE_DIR=1


./setup.sh email add noreply@domain.net
docker compose up -d



sudo cat config/postfix-accounts.cf
docker exec -it mailserver doveadm user '*'


# Очередь отправки писем
docker exec -it mailserver postqueue -p

# Основной лог для Postfix
docker exec -it mailserver tail -n 100 /var/log/mail.log

# Проверка PTR (обратной записи). Без неё Яндекс/Google часто отказываются принимать.
dig -x 185.159.129.62
dig +short -x 185.159.129.62

# Добавление пользователя
docker compose exec mailserver setup email add admin@zlatov.su

# Список текущих пользователей
cat config/postfix-accounts.cf

# Добавить алиас (перенаправление входящей почты)
mcedit config/postfix-virtual.cf # редактируем конф файл
noreply@zlatov.su admin@zlatov.su # добавляем такую строку
docker compose exec mailserver postmap /etc/postfix/virtual # достаточно этой команды чтобы вступило в силу
docker compose restart mailserver # на всякий случай если сомневаемся
docker exec -it mailserver tail -n 100 /var/log/mail.log # смотрим лог если сомневаемся ещё больше
docker compose logs -f mailserver # смотрим лог если совсем амнезия
```




## Проверка мать его настроек почтового сервера

✅ 1. PTR-запись (обратная DNS-запись)

```sh
dig +short -x 185.159.129.62
# Если пусто — нет PTR. Настраивается у хостера
```

✅ 2. SPF (Sender Policy Framework)

```sh
dig +short TXT zlatov.su
# Ожидаем:
# v=spf1 a mx ip4:185.159.129.62 ~all
# Если пусто, то добавляем TXT запись:
# ключ: @
# значение: v=spf1 a mx ip4:185.159.129.62 ~all

```

✅ 3. DKIM (DomainKeys Identified Mail)

```sh
sudo cat config/opendkim/keys/zlatov.su/mail.private
# Ожидаем увидеть приватный ключ, если нет - генерируем его так:
# docker compose exec mailserver setup config dkim
sudo cat config/opendkim/keys/zlatov.su/mail.txt
# Ожидаем многосторочной херни разбитой по 255 символов
dig +short TXT mail._domainkey.zlatov.su
# Ожидаем эту многострочную херню из TXT записи:
# ключ: mail._domainkey.zlatov.su
# значение: эта херня
```

✅ 4. DMARC

```sh
dig +short TXT _dmarc.zlatov.su
# Если пусто — Добавляем TXT запись:
# ключ (без точек блять): _dmarc
# значение: v=DMARC1; p=none; rua=mailto:admin@zlatov.su
```

✅ Проверка SSL

```sh
openssl s_client -connect mail.zlatov.su:465 -servername mail.zlatov.su | openssl x509 -noout -dates -issuer -subject
# depth=2 C = US, O = Internet Security Research Group, CN = ISRG Root X1
# verify return:1
# depth=1 C = US, O = Let's Encrypt, CN = R11
# verify return:1
# depth=0 CN = mail.zlatov.su
# verify return:1
# notBefore=Apr  5 15:37:30 2025 GMT
# notAfter=Jul  4 15:37:29 2025 GMT
# issuer=C = US, O = Let's Encrypt, CN = R11
# subject=CN = mail.zlatov.su
```

## Прочитка писем на серваке

```sh
sudo apt install mutt

mkdir -p ~/.mutt
mcedit ~/.mutt/muttrc

sudo find /var -type d -name "*noreply*" 2>/dev/null
/var/lib/docker/volumes/mailserver_maildata/_data/zlatov.su/noreply

# ~/.mutt/muttrc
set spoolfile="/var/lib/docker/volumes/mailserver_maildata/_data/zlatov.su/noreply"
set folder="/var/lib/docker/volumes/mailserver_maildata/_data/zlatov.su/noreply"
set mbox_type=Maildir
set mask="!^\\.[^.]"
set sort=reverse-date-sent
set index_format="%4C %Z %{%b %d} %-15.15L (%4c) %s"
set date_format="%b %d %H:%M"
set charset="utf-8"
```


## Проверяем письма на антиспам и другое https://www.mail-tester.com

```bash
# swaks - хороший бомбардировщик письмами из консоли.
swaks --to test-z3tw4cplh@srv1.mail-tester.com \
      --from noreply@zlatov.su \
      --server mail.zlatov.su \
      --port 587 \
      --auth LOGIN \
      --auth-user noreply@zlatov.su \
      --auth-password '' \
      --tls \
      --header "Date: $(date -R)" \
      --header "From: noreply@zlatov.su" \
      --header "To: test-z3tw4cplh@srv1.mail-tester.com" \
      --header "Subject: =?UTF-8?B?0KLQtdGB0YI=?=" \
      --header "Content-Type: text/plain; charset=UTF-8" \
      --header "Content-Transfer-Encoding: 8bit" \
      --header "MIME-Version: 1.0" \
      --body "Привет! Всё подписано корректно."
```
