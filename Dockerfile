FROM debian:stretch
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.10
ENV FS_VERSION 1.10.1
ENV REFRESHED_AT 2019-08-20

RUN apt update && apt -y --quiet upgrade && apt install -y --quiet gnupg2 wget \
    && wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/debian-release/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && apt update && apt clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY LICENSE /LICENSE
