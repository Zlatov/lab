```bash
ssh ihor
adduser -home /home/deployer -shell /bin/bash deployer
adduser deployer sudo
```

```bash
ssh ihor_dep
sudo apt update
sudo apt install git
sudo apt install gcc
sudo apt install make
sudo apt install curl
sudo apt install mc
sudo apt install -y gnupg2
sudo apt install npm
sudo apt install postgresql

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

# capistrano install dirs
cap ihor deploy:setup
cap ihor deploy:check
```

```bash
ssh ihor_dep

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
~/.rbenv/bin/rbenv init
# mc edit file ...
# relogin!
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# for ruby
sudo apt install -y libreadline-dev zlib1g-dev
# ruby
rbenv install <version>

# gem
gem update --system

# for bundler
sudo apt install libmysqlclient-dev
sudo apt install libpq-dev
sudo apt install -y sqlite3 libsqlite3-dev
# bundler
gem install bundler -v 2.0.1

# rails
gem install rails
```
