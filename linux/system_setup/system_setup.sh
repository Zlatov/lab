#!/usr/bin/env bash

# 
# cd ~ && mkdir -p projects/my/lab && git clone git@github.com:Zlatov/lab.git projects/my/lab && projects/my/lab/linux/system_setup/system_setup.sh
# cd ~ && sudo projects/my/lab/linux/system_setup/system_setup.sh
# 

lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

echoc 'Лаборатория склонирована.' green

echoc 'Установка yarn.' yellow

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

echoc 'Yarn установлен.' yellow
