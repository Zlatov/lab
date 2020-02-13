# step1
docker stop zenonline && docker rm zenonline && docker run -itd --name zenonline zenoweb/zenonline:ru && docker attach zenonline

apt install -qq -y --no-install-recommends git curl mc htop sudo
apt -qq clean

docker commit zenonline zenoweb/zenonline:step1
docker push zenoweb/zenonline:step1

# step2_rbenv
docker stop zenonline && docker rm zenonline && docker run -itd --name zenonline zenoweb/zenonline:step1 && docker attach zenonline

apt install -qq -y --no-install-recommends ca-certificates build-essential
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo $'eval "$(rbenv init -)"\n'"$(cat ~/.bashrc)" > ~/.bashrc
echo $'export PATH="$HOME/.rbenv/bin:$PATH"\n'"$(cat ~/.bashrc)" > ~/.bashrc
. ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
apt -qq clean

docker commit zenonline zenoweb/zenonline:step2_rbenv
docker push zenoweb/zenonline:step2_rbenv

# step3_ruby
docker stop zenonline && docker rm zenonline && docker run -itd --name zenonline zenoweb/zenonline:step2_rbenv && docker attach zenonline

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
apt install -qq -y --no-install-recommends libsqlite3-dev libpq-dev
apt install -qq -y --no-install-recommends libssl-dev libreadline-dev zlib1g-dev
rbenv install 2.6.5 && rbenv global 2.6.5
gem install bundler -v 2.1.4
apt -qq clean
mkdir -p /app/zenonline
cd /app/zenonline && ruby -v

docker commit zenonline zenoweb/zenonline:step3_ruby
docker push zenoweb/zenonline:step3_ruby

# step4_postgres
docker stop zenonline && docker rm zenonline && docker run -itd --name zenonline zenoweb/zenonline:step3_ruby && docker attach zenonline

apt install -y postgresql
service postgresql start
sudo -u postgres psql -c "CREATE USER zenonline WITH password '<password>';"
sudo -u postgres psql -c "ALTER USER zenonline CREATEDB;"
mcedit /etc/postgresql/10/main/pg_hba.conf
# 
# Комментируем строку:
# ```
# local   all             all                                     peer
# ```
# Добавляем после неё строки:
# ```
# local   template1       zenonline                               md5
# local   zenonline       zenonline                               md5
# local   zenonline_test  zenonline                               md5
# ```
# 
service postgresql restart
createdb -U zenonline zenonline
createdb -U zenonline zenonline_test
echo '#/bin/bash' > /entrypoint.sh
echo 'set -eu' >> /entrypoint.sh
echo 'service postgresql start' >> /entrypoint.sh
apt -qq clean

docker commit zenonline zenoweb/zenonline:step4_postgres
docker push zenoweb/zenonline:step4_postgres

# step5_yarn
docker stop zenonline && docker rm zenonline && docker run -itd --name zenonline zenoweb/zenonline:step4_postgres && docker attach zenonline

apt install -qq -y --no-install-recommends npm
npm install -g n
n stable
. ~/.bashrc
apt install -qq -y --no-install-recommends gnupg2
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update && apt install yarn
apt -qq clean

docker commit zenonline zenoweb/zenonline:step5_yarn
docker push zenoweb/zenonline:step5_yarn




# Использование
cd path/to/project
docker volume create zenonline_postgresql
cp variables-example.env variables.env && mcedit variables.env
docker run --name zenonline -itd -v $(pwd):/app/zenonline -v zenonline_postgresql:/var/lib/postgresql/10/main/base zenoweb/zenonline:step5_yarn
docker exec -it zenonline bash -lic 'cd /app/zenonline && bundle'
docker exec -it zenonline bash -lic 'cd /app/zenonline && yarn --network-timeout 1000000'
docker exec -it zenonline bash -lic 'cd /app/zenonline && ./bash/recreate/database.sh'
docker exec -it zenonline bash -lic 'cd /app/zenonline && /root/.rbenv/bin/rbenv exec bundle exec puma -C /app/zenonline/config/puma.rb --daemon'
docker exec -it zenonline bash -lic 'cd /app/zenonline && /root/.rbenv/bin/rbenv exec bundle exec pumactl -F /app/zenonline/config/puma.rb stop'
docker exec -it zenonline bash -lic 'cd /app/zenonline && /root/.rbenv/bin/rbenv exec bundle exec pumactl -F /app/zenonline/config/puma.rb phased-restart'
