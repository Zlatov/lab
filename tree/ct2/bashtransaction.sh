#/bin/bash

# export MYSQL_PWD="***"
# mysql -uroot -Dtreect2 -e "START TRANSACTION;"
# mysql -uroot -Dtreect2 < bashtransaction.sql
# if [[ $? -eq 1 ]]
# 	then
# 		mysql -uroot -Dtreect2 -e "ROLLBACK;"
#         echo -e "Ошибка, откат."
# 	else
# 		mysql -uroot -Dtreect2 -e "COMMIT;"
#         echo -e "Ок, коммит."
# fi

export MYSQL_PWD="***"
exec 3> >(mysql -uroot -Dtreect2)
echo "START TRANSACTION;" >&3
cat bashtransaction.sql >&3
if [[ $? -eq 1 ]]
	then
		echo "ROLLBACK;" >&3
        echo "Ошибка, откат."
	else
		echo "COMMIT;" >&3
        echo "Ок, коммит."
fi
exec 3>&-
