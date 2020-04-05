# Laboratory

## Установка проекта Laboratory

```bash
sudo apt install -y git && \
cd ~ && mkdir -p projects/my/lab && \
git clone git@github.com:Zlatov/lab.git projects/my/lab && \
cd ~/projects/my/lab && git submodule update --init --recursive
```

```bash
# Если не установлен yarn, то можно установить вместе с остальным ПО - смотри следующий раздел.
cd ~/projects/my/lab && yarn
```

## Установка/настройка ПО под Ubuntu

2. Програмно: `cd ~ && projects/my/lab/linux/system_setup/system_setup.sh`
1. Вручную: [linux/system_setup/system_setup.md](linux/system_setup/system_setup.md)
