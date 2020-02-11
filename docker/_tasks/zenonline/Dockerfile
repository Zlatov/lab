# docker build -t zenoweb/zenonline:dockerfile .
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq clean && apt-get -qq update && apt-get -qq dist-upgrade

RUN	apt-get install -y locales
RUN locale-gen --purge "ru_RU.UTF-8"
RUN dpkg-reconfigure --frontend noninteractive locales

RUN apt-get -qq update && apt-get -qq dist-upgrade && apt-get install -qq -y --no-install-recommends \
  git \
  mc \
  htop

RUN	alias mc='LANG=ru_RU.UTF-8 mc'

RUN	apt-get install postgresql -y

# RUN	apt install systemd
# RUN	systemctl

ENTRYPOINT service postgresql start && bash
# ENTRYPOINT ["/usr/sbin/service", "postgresql", "restart", "&&", "/bin/bash"]


# docker volume create zenonline_postgresql

# docker rm zenonline
# docker run --name zenonline -itd -p 9432:5432 -v zenonline_dockerfile_postgresql:/var/lib/postgresql/10/main/base zenoweb/zenonline:dockerfile
# docker attach zenonline
# service postgresql status
# docker push zenoweb/zenonline:dockerfile
