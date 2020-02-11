# docker build -t zenoweb/zenonline:dockerfile .
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq clean && apt-get -qq update && apt-get -qq dist-upgrade

RUN	apt-get install -y locales
RUN locale-gen --purge "ru_RU.UTF-8"
RUN dpkg-reconfigure --frontend noninteractive locales

RUN apt-get -qq update && apt-get -qq dist-upgrade && apt-get install -qq -y --no-install-recommends \
  git \
  ca-certificates \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libpq-dev \
  curl \
  mc \
  htop

RUN	alias mc='LANG=ru_RU.UTF-8 mc'

RUN	apt-get install postgresql -y

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src

RUN echo 'eval "$(rbenv init -)"\n'"$(cat ~/.bashrc)" > ~/.bashrc
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"\n'"$(cat ~/.bashrc)" > ~/.bashrc

RUN mkdir -p /root/.rbenv/plugins
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build

RUN /root/.rbenv/bin/rbenv install 2.6.5
RUN /root/.rbenv/bin/rbenv global 2.6.5
RUN /root/.rbenv/shims/gem install bundler -v 2.1.4

# Для sqlite
RUN apt-get install -qq -y --no-install-recommends \
	sudo \
	libsqlite3-dev

# Для yarn
RUN apt-get update && apt-get install -y gnupg2

# Для освобождения дискового пространствва за счет удаления полученных *.deb-файлов пакетов.
RUN apt-get -qq clean

ENTRYPOINT service postgresql start && bash




# docker volume create zenonline_postgresql
# docker rm zenonline
# docker run --name zenonline -itd -p 9432:5432 -v $(pwd):/app/zenonline -v zenonline_postgresql:/var/lib/postgresql/10/main/base zenoweb/zenonline:dockerfile
# docker push zenoweb/zenonline:dockerfile




# docker run --name zenonline -itd -p 9432:5432 -v $(pwd):/app/zenonline -v zenonline_postgresql:/var/lib/postgresql/10/main/base zenoweb/zenonline:latest
# docker exec -it zenonline bash -lic 'cd /app/zenonline && bundle'
