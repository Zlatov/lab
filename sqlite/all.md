# SQLite

Так себе БД.

sqlitebrowser - ui-редактор для линукс ОС.

## Установка

```sh
# Где качать старые версии: https://www.sqlite.org/index.html https://www.sqlite.org/changes.html
wget https://www.sqlite.org/{год,например:2018}/sqlite-autoconf-{version,например:3260000}.tar.gz
# А потом нужно разархивить и скомпилить
tar xvfz sqlite-autoconf-*.tar.gz
cd sqlite-autoconf-{version}
./configure --prefix=/iad
./configure --prefix=/{любое_новое_коневое_место_можно:usr}
make -j {number_of_cores}
sudo make install
/iad/bin/sqlite3 --version
# Чтобы заменить стандартный бинарник своим, нужно в .bashrc
export PATH="/iad/bin:$PATH"
```
