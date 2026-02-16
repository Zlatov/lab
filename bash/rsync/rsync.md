```bash
# Копировать только:
# ~/app/appname/public/product/*1*/attachments/*2*
# 
# где:
# *1* - произвольный артикул товара
# *2* - любые файлы и папки (рекурсивно)
# 
# Параметр `--prune-empty-dirs` - удалять пустые директории после копирования,
# например ~/app/appname/public/product/000011/images/
# 
# «Локально» - просто без `ssh_alias:`
rsync -av --progress --prune-empty-dirs \
  --include='*/' \
  --include='attachments/' \
  --include='attachments/***' \
  --exclude='*' \
  ssh_alias:~/app/appname/public/product/ ./product_attachments/
```
