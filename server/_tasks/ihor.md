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
```
