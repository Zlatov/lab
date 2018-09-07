#!/usr/bin/env bash

# 
# git-symbolic-ref - Read, modify and delete symbolic refs
# 
# Синтаксис
# git symbolic-ref [-m <reason>] <name> <ref>
# git symbolic-ref [-q] [--short] <name>
# git symbolic-ref --delete [-q] <name>
# 
# Опции
# -q, --quiet
# Не выдавайте сообщение об ошибке, если <имя> не является символом ref, но
# является отдельным HEAD; вместо этого выходите без ненужного состояния.
# --short
# При отображении значения <name> в качестве символьного ref попытайтесь
# сократить значение, например. от refs / heads / master до master.
# 


echo $(git symbolic-ref --short HEAD)
echo $(git symbolic-ref -q HEAD)
echo $(git symbolic-ref --short -q HEAD)
