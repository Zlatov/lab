При старте системы загружается файл _/etc/rc.d/rc.local_:

```bash
# /etc/rc.d/rc.local
su - deployer -c /path/to/scripts/script.sh
```

```bash
sudo update-rc.d apache2 disable # отключить автозагрузку сервиса
sudo update-rc.d nginx enable # включить автозагрузку сервиса

sudo update-rc.d -f apache2 remove # удалить сам сервис
```
