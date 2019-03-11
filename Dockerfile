FROM debian:stretch
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.8
ENV FS_VERSION 1.8.5
ENV REFRESHED_AT 2019-03-11

RUN apt update && apt -y --quiet upgrade && apt install -y --quiet gnupg2 wget \
    && wget -O - https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && apt update && apt clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY LICENSE /LICENSE
