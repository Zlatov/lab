# docker build -t zenoweb/zenonline:ru .
# docker run -itd --name zenonline zenoweb/zenonline:ru
# docker stop zenonline && docker rm zenonline && docker build -t zenoweb/zenonline:ru . && docker run -itd --name zenonline zenoweb/zenonline:ru
FROM ubuntu:18.04
RUN apt-get update && apt-get install -y locales

# Locale
RUN sed -i -e \
  's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
   && locale-gen

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

# +Timezone (если надо на этапе сборки)
ENV TZ Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -qq clean

RUN touch entrypoint.sh
RUN chmod u+x entrypoint.sh

ENTRYPOINT /entrypoint.sh && bash
