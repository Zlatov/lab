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
# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
~/.rbenv/bin/rbenv init
# mc edit file ...
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```
