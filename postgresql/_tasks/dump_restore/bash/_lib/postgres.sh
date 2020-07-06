if [[ -f ../_config/postgres.sh ]]
then
	set -a
	. ../_config/postgres.sh
	set +a
else
	echo "Отсутствует конфигурационный файл, выполните: cp bash/_config/postgres-example.sh bash/_config/postgres.sh" 1>&2
	echo "Редактировать конфигурационный файл: mcedit bash/_config/postgres.sh."
	exit 1
fi

if [[ -z ${DATABASE_NAME-} ]]
then
	echo "Переменная DATABASE_NAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${USERNAME-} ]]
then
	echo "Переменная USERNAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${PGPASSWORD-} ]]
then
	echo "Переменная PGPASSWORD не установлена." 1>&2
	exit 1
fi
