FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs \
    libssl-dev libmagic-dev libjemalloc-dev \
    build-essential default-libmysqlclient-dev curl file lftp \
    imagemagick

ARG USER=docker
ARG UID=1000
ARG GID=1000
# default password for user
ARG PW=docker

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | chpasswd
# Setup default user, when enter docker container

RUN mkdir /app

WORKDIR /app
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

RUN chown ${UID}:${GID} /app
USER ${UID}:${GID}