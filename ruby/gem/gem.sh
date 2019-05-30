#!/usr/bin/env bash

gem --help
gem help commands

exit 0

gem list # — список установленных гемов с версиями;
gem which gem_name # — где же гем gem_name;
gem environment # — инфа обо всей гем среде (верия руби, рубигема, пути и т.д.);
gem list ^rails$ --remote --all # — посмотреть доступные версии пакета

gem install bundler #
gem install rails #
