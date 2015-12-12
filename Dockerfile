FROM debian:jessie
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.6
ENV FS_VERSION 1.6.5
ENV REFRESHED_AT 2015-12-12

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
    && apt-get install -y --quiet --force-yes locales curl wget libvorbis0a libogg0 libsqlite3-0 libpcre3 libspeex1 libspeexdsp1 libedit2 libjpeg62-turbo librabbitmq1 \
    && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.6/ jessie main" > /etc/apt/sources.list.d/freeswitch.list \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get update && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY LICENSE /LICENSE
