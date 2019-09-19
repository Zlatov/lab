# Доступы

Общая логика внесения изменений: перед добавлением — `pull`, после — `push`.

Как бы я хотел чтобы выглядели команды:

```
accesses pull my
accesses open my
accesses push my
accesses open zenon
accesses open sshconfig
accesses open hosts
```

<del>./accesses/bash/pull "my" && subl \~/projects/my/lab/accesses/accesses/"my".yml</del>

## Установка

`curl -L -o ~/accesses.sh https://raw.githubusercontent.com/Zlatov/lab/master/accesses/bin/accesses && chmod u+x ~/accesses.sh && sudo ~/accesses.sh`
