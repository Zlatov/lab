# rsub, rmate - редактирование файлов удалённого сервера на локальной машине в сублайм (ssh)

## Устнаовка

1.  Установить плагин в сублайм:

    Preference -> Packag Control -> `install` -> `rsub`

2.  Добавить к хосту проброс порта: 

    `subl ~/.ssh/config`

    ```sh
    Host test
      User user
      Hostname 11.111.11.111
      # RemoteForward 52698 localhost:52698
      RemoteForward 52698 127.0.0.1:52698
    ```

3.  На удалённой машин установить rmate:

    ```sh
    wget -O ~/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
    chmod u+x ~/rmate
    cd ~ && touch temp && ~/rmate temp
    ```

    и для судорес

    ```sh
    sudo cp rmate /usr/bin/
    sudo chmod u+rwx,g+rx,g-w,o+rx,o-w /usr/bin/rmate
    sudo cp /usr/bin/rmate /usr/bin/rsubl
    ```

    ИЛИ установить как в доке: https://github.com/textmate/rmate

    А ЛУЧШЕ как тут: https://github.com/aurora/rmate :

    ```sh
    sudo wget -O /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
    sudo chmod a+x /usr/local/bin/rmate
    ```
