# Доступы

Общая логика внесения изменений: перед добавлением — `pull`, после — `push`.

Как бы я хотел чтобы выглядели команды:

```bash
# Необходимо внести изменения в собственные пароли:
zaccesses my
# Редактирование файла
zaccesses -s my

zaccesses sshconfig
# Редактирование файла
zaccesses sshconfig -s

zaccesses hosts
zaccesses hosts -s
```

## Установка

```sh
cd ~ && mkdir accesses
curl -L -o ~/install_accesses.sh https://raw.githubusercontent.com/Zlatov/lab/master/accesses/bin/install.sh && chmod u+x ~/install_accesses.sh && sudo ~/install_accesses.sh && rm ~/install_accesses.sh
```

Добавить в `mcedit ~/.bashrc`

```bash
export YANDEX_PASSWORD=password
```
