FROM ruby:3.1.2-alpine

RUN apk add --update --virtual \
  runtime-deps \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  libffi-dev \
  readline \
  postgresql-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  bash \
  && rm -rf /var/cache/apk/*

# telnet: apk add busybox-extras
RUN apk add --update \
  busybox-extras \
  libcurl \
  curl-dev \
  sqlite-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app
COPY Gemfile .
# COPY Gemfile.lock .

# ENV BUNDLE_PATH /gem

RUN bundle install
# RUN gem install bundler && bundle install --jobs=3 --retry=3
RUN rm Gemfile
RUN rm Gemfile.lock
