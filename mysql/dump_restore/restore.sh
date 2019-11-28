mysql --database="$DBNAME" --user="$DBUSER" --password="$DBPASS" < ./"$1"

mysql --one-database … # Восстановление из мультидампа.
mysql --init-command="SET SESSION FOREIGN_KEY_CHECKS=0;" … # Отключить слежение за внешними ключами при импорте.
