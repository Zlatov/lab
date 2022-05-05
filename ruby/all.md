# Ruby

## rbenv

Управление версиями ruby.




### Установка rbenv

Из [гит репозитория](https://github.com/rbenv/rbenv) по мануалу или:

```bash
# Наверняка понадобится
sudo yum install gcc-c++
sudo apt install gcc
# или
sudo apt-get install build-essential

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
# ВЕСЬ ПОСЛЕДУЮЩИЙ КОД ДЛЯ ФАЙЛА ~/.bashrc ДОЛЖЕН БЫТЬ ВСТАВЛЕН
# ДО ПРОВЕРКИ НА ИНТЕРАКТИВНОСТЬ!!!
# ```
# # If not running interactively, don't do anything
# ```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

~/.rbenv/bin/rbenv init
# Добавить код в ~/.bashrc или ~/.bash-profile:
# eval "$(rbenv init -)"

# Перезапустить shell.

# Установить ruby-build.
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Протестить.
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

__Так же установить плагин для rbenv__

[для установки версий](https://github.com/rbenv/ruby-build)

__Следить за состоянием rbenv__:

* `cd ~/.rbenv && git pull`
* `cd ~/.rbenv/plugins/ruby-build && git pull`


### Установка ruby через rbenv

```sh
# Наверняка понадобится
sudo apt install -y libssl-dev
sudo apt install -y zlib1g-dev
```

`rbenv install -l` — список доступных для установки версий;
`rbenv install 2.3.1` — установить указанную версию;
`rbenv versions` — список установленных версий;
`rbenv local 2.3.1` — назначить версию для текущего проекта;
`rbenv global 2.4.1` — назначить глобальную версию.
`rbenv uninstall 2.4.1`




## gem - менеджер пакетов ruby

см. файл ruby/gem/gem.md




## bundle - гем - менеджер пакетов приложения

см. файл ruby/bundle/bundler.md




## Консоль

`load './somefile.rb'` — выполнить файл из рельсовой консоли (rails c).
`ruby './somefile.rb'` — выполнить файл из шел.
`irb` — запустить интерактивную оболочку руби.




### Запретить кешировать модули и классы для rails c

Добавить в .bashrc строку: `export DISABLE_SPRING=1`




## Ruby ООП

### load, require, include, extend

*   `load` — включить файл в другой файл, файл загружается каждый раз в момент
    вызова (не нужно перезапускать сервер рельсы чтобы получить результат
    изменений в файле).
*   `require` — включить файл в другой файл, файл загружается в память и
    используется (нужно пезапустить сервер рельсы для получения результата
    изменений в файле).

*   `include` — методы модуля становятся доступными для выполнения в классе, для
    добавления функционала к объекту класса.
*   `extend` — методы модуля становятся доступными для выполнения в классе, для
    расширения функционала класса.
