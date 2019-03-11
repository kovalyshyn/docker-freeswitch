FROM debian:stretch
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.8
ENV FS_VERSION 1.8.5
ENV REFRESHED_AT 2019-03-11

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
    && apt-get install -y --quiet --force-yes gnupg2 wget \
    && wget -O - https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt update && apt clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY LICENSE /LICENSE
