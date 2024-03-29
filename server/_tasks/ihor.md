```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub ihor
ssh ihor
adduser -home /home/deployer -shell /bin/bash deployer
adduser deployer sudo
```

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub ihor_dep
ssh ihor_dep
sudo apt update
sudo apt install -y git
sudo apt install -y htop
sudo apt install -y gcc
sudo apt install -y make
sudo apt install -y curl
sudo apt install -y mc
sudo apt install -y gnupg2
sudo apt install -y npm
sudo apt install -y postgresql
sudo apt install -y nginx

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
# Добавить на github.com
```

```bash
# localhost

# capistrano
cap ihor deploy:check
```

```bash
ssh ihor_dep

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
~/.rbenv/bin/rbenv init
# Те команды которые рекомендую записать в .bash_profile:
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# так же нужно записать в .bashrc ДО ПРОВЕРКИ НА ИНТЕРАКТИВНОСТЬ
# Перезапустить шел!
ssh ihor_dep
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# for ruby
# Создать swap-файл? Читать в server/all.md
sudo apt install -y libreadline-dev zlib1g-dev
# ruby
rbenv install 2.5.3

# for gem
rbenv global 2.5.3
# gem
gem update --system

# for bundler
sudo apt install -y libmysqlclient-dev
sudo apt install -y libpq-dev
sudo apt install -y sqlite3 libsqlite3-dev
# bundler
gem install bundler -v 2.0.1
gem install bundler -v 2.0.1 --force

# rails
gem install rails
gem install rails -v 5.1.6

# DB
# Вначале позаботиться о клатере с рукоязычной локалью, см файл postgresql/cluster/locales.md
sudo mcedit /etc/postgresql/10/main/pg_hba.conf
# # TYPE  DATABASE        USER            ADDRESS                 METHOD
# local   lorem_rails,lorem_rails_test,template1  lorem_rails     md5
sudo service postgresql restart
sudo -u postgres psql
CREATE USER lorem_rails WITH password '<password>';
ALTER USER lorem_rails CREATEDB;
ALTER USER lorem_rails WITH SUPERUSER;
mcedit ~/.bashrc
# export LOREM_RAILS_PSQL_USER=lorem_rails
# export LOREM_RAILS_PSQL_PASSWORD=<password>
PGPASSWORD=$LOREM_RAILS_PSQL_PASSWORD createdb --encoding=UTF8 --locale=ru_RU.utf8 -U lorem_rails lorem_rails -W
PGPASSWORD=$LOREM_RAILS_PSQL_PASSWORD createdb --encoding=UTF8 --locale=ru_RU.utf8 -U lorem_rails lorem_rails_test -W
# Убедиться что переменные окружения попадают в шел используемый капистрано и ssh.
# Можно проставить метки включения файла в каждом из файлов:
# echo "> .profile loaded!"
# echo "> .bash_profile loaded!"
# echo "> .bashrc loaded!"

# media
curl -L -o ~/images_pull_jpg.sh https://raw.githubusercontent.com/Zlatov/lab/master/images/pull/jpg.sh && chmod u+x ~/images_pull_jpg.sh && ~/images_pull_jpg.sh
ln -s ~/images/jpg ~/app/lorem_rails/shared/public/images

# nginx
sudo touch /etc/nginx/sites-available/lorem_rails
sudo mcedit /etc/nginx/sites-available/lorem_rails
#server {
#    listen *:80;
#    server_name lorem-rails.ihor, www.lorem-rails.ihor;
#    client_max_body_size 256m;
#    location / {
#        proxy_pass http://127.0.0.1:48888;
#        proxy_set_header Host $host;
#        proxy_set_header X-Forwarded-For $remote_addr;
#        port_in_redirect off;
#        proxy_connect_timeout 600;
#        proxy_read_timeout 600;
#        fastcgi_read_timeout 600s;
#    }
#}
#server {
#    listen *:80;
#    server_name lorem-rails-test.ihor, www.lorem-rails-test.ihor;
#    client_max_body_size 256m;
#    location / {
#        proxy_pass http://127.0.0.1:48889;
#        proxy_set_header Host $host;
#        proxy_set_header X-Forwarded-For $remote_addr;
#        port_in_redirect off;
#        proxy_connect_timeout 600;
#        proxy_read_timeout 600;
#        fastcgi_read_timeout 600s;
#    }
#}
cd /etc/nginx/sites-enabled/
sudo ln -s ../sites-available/lorem_rails
sudo nginx -s reload
```
