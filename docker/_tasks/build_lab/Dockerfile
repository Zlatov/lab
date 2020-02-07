# FROM ubuntu:18.04
# ENV DEBIAN_FRONTEND noninteractive
# # ENV MYSQL_PWD lab
# RUN apt-get clean && apt-get update && apt-get install -y locales
# RUN locale-gen ru_RU
# RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales
# RUN apt-get install mysql-server -y


apt-get clean
apt-get update
apt-get install -y locales
locale-gen ru_RU.UTF-8
dpkg-reconfigure locales
alias mc='LANG=ru_RU.UTF-8 mc'
apt-get install mysql-server -y
service mysql start
mysql_secure_installation
mysql -uroot -p
	FLUSH PRIVILEGES;
  UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user = 'root';
  FLUSH PRIVILEGES;
  GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'lab' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
  exit
