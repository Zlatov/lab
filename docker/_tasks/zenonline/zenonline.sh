docker run --name zenonline -it zenoweb/zenonline:ubuntu-18.04
	apt clean
	apt update
	apt install -y locales
	locale-gen ru_RU.UTF-8
	dpkg-reconfigure locales
	apt install postgresql
	apt install systemd
	apt install systemd
	systemctl
	service postgresql status
	service postgresql start
	service postgresql status
	apt install mc
	alias mc='LANG=ru_RU.UTF-8 mc'
	mc
	apt install htop
	htop

docker volume create zenonline_postgresql
docker commit -m "+postgresql" zenonline zenoweb/zenonline:postgresql
docker push zenoweb/zenonline:postgresql

docker rm $(docker ps -a -q -f status=exited)
docker run --name zenonline -it -p 9432:5432 -v zenonline_postgresql:/var/lib/postgresql/10/main/base zenoweb/zenonline:postgresql

-p 9432:5432 -v zenonline_postgresql:/var/lib/postgresql/10/main/base


