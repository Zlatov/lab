#!/usr/bin/env bash
# !/bin/bash

set -exu

# -e Выйти немедленно, если команда выходит с ненулевым статусом.
# -x Печатать команды и их аргументы по мере их выполнения.
# -u Выйти немедленно, если было обращение к неопределённой переменной.
# -a Установленные переменные станут переменными окружения последующих команд.

cd "$(dirname "${0}")"