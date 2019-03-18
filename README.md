# Laboratory

## Установка

Клонирование файлов в предопределённое место.

```
cd ~ && mkdir -p projects/my/lab && \
git clone git@github.com:Zlatov/lab.git projects/my/lab && \
cd ~/projects/my/lab && git submodule update --init --recursive
```

```
yarn
cd semantic
gulp build        # Установит по инструкции semantic.json
```

## Установка/настройка ПО под Ubuntu

1. Програмно: `cd ~ && projects/my/lab/linux/system_setup/system_setup.sh`
1. Вручную: [linux/system_setup/system_setup.md](linux/system_setup/system_setup.md)
