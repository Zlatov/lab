# Google Chrome

## Настройки

### Удаление принудительного https запроса к сайту

chrome://net-internals/#hsts
А ещё приходится очищать всю историю за всё время включая куки файлы.


### Отключение запроса пароля на связки ключей при запуске хрома

__Способ 1. Через GUI__

Прежде всего, нам нужно найти пароли и ключи шифрования. Также вы можете открыть
его из терминала:

```sh
seahorse
```

Вам нужно перейти на вкладку «Пароли», и там вы увидите папку: «Пароли: логин».

Щелкните правой кнопкой мыши, а затем измените пароль. Введите свой старый
пароль и оставьте пустыми поля для нового пароля.

Теперь вы можете попробовать перезапустить, теперь запрос не должен появиться!

__Способ 2. Через параметры запуска__

К сожалению отнимает возможность использовать сохранённые пароли в гугл
аккаунте.

```sh
# Эта команда добавляет --password-store=basic %U в конец любой строки в
# /usr/share/applications/google-chrome.desktop которая начинается с Exec=
sudo sed -i '/^Exec=/s/$/ --password-store=basic %U/' /usr/share/applications/google-chrome.desktop
```


## Обновить версию

```sh
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Обновляем:
$ sudo apt-get update
$ sudo apt-get --only-upgrade install google-chrome-stable

# Если при использовании хрома у вас появилась ошибка NET::ERR_CERT_WEAK_SIGNATURE_ALGORITHM:
# Google Chrome NET::ERR_CERT_WEAK_SIGNATURE_ALGORITHM
# То нужно установить  Network Security Service libraries (libnss):
sudo apt-get install libnss3-1d

# Убиваем старые процессы хрома:
$ killall google-chrome

# Все. Можно пользоваться. 
```

## Если Google Chrome установлен через flatpak и не видит локальные файлы ~/README.md

```sh
flatpak override com.google.Chrome --filesystem=home
```
