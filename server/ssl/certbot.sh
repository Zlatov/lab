sudo certbot certonly --webroot -w /var/www/test.losst.ru -d test.losst.ru -d www.test.losst.ru
# `--webroot -w /var/www/test.losst.ru` - путь который доступен с внешки

sudo certbot certonly --webroot -w /home/zlatov/app/market/public -d zenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/zlatov/app/admin/public -d admin.zenonline-zlatov-stage.klej.ru
