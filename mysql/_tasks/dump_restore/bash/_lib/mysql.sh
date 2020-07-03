if [[ -f ../_config/mysql.sh ]]
then
	set -a
	. ../_config/mysql.sh
	set +a
else
	echo "Отсутствует конфигурационный файл для mysql, выполните: cp bash/_config/mysql-example.sh bash/_config/mysql.sh." 1>&2
	echo "Редактировать конфигурационный файл: mcedit bash/_config/mysql.sh."
	exit 1
fi

if [[ -z ${DATABASE_NAME-} ]]
then
	echo "Переменная DATABASE_NAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${MYSQL_USERNAME-} ]]
then
	echo "Переменная MYSQL_USERNAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${MYSQL_HOST-} ]]
then
	echo "Переменная MYSQL_HOST не установлена." 1>&2
	exit 1
fi
if [[ -z ${MYSQL_PWD-} ]]
then
	echo "Переменная MYSQL_PWD не установлена." 1>&2
	exit 1
fi
