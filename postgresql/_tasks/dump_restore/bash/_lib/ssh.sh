if [[ -f ../_config/ssh.sh ]]
then
	set -a
	. ../_config/ssh.sh
	set +a
else
	echo "Отсутствует конфигурационный файл для ssh, выполните: cp bash/_config/ssh-example.sh bash/_config/ssh.sh." 1>&2
	echo "Редактировать конфигурационный файл: mcedit bash/_config/ssh.sh."
	exit 1
fi

if [[ -z ${REMOTE_SERVER-} ]]
then
	echo "Переменная REMOTE_SERVER не установлена." 1>&2
	exit 1
fi
if [[ -z ${REMOTE_PATH-} ]]
then
	echo "Переменная REMOTE_PATH не установлена." 1>&2
	exit 1
fi
