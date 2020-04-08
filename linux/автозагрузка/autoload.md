

```bash
sudo update-rc.d apache2 disable # отключить автозагрузку сервиса
sudo update-rc.d nginx enable # включить автозагрузку сервиса

sudo update-rc.d -f apache2 remove # удалить сам сервис
```
