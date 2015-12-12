# vim:set ft=dockerfile:
# Install FreeSWITCH with vanilla config
FROM debian:wheezy
MAINTAINER Vitaly Kovalyshyn "v.kovalyshyn@webitel.com"

ENV FS_MAJOR 1.4
ENV FS_VERSION 1.4.26
ENV REFRESHED_AT 2015-12-12

RUN apt-get update && apt-get -y --quiet --force-yes upgrade \
    && apt-get install -y --quiet --force-yes locales curl wget \
    && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - \
    && echo "deb http://files.freeswitch.org/repo/deb/debian/ wheezy main" > /etc/apt/sources.list.d/99FreeSWITCH.list \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get -y --quiet update \
    && apt-get -y install freeswitch-all freeswitch-mod-shout \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/freeswitch/conf \
    && rm -rf /usr/share/freeswitch/sounds \
    && mkdir -p /docker-entrypoint.d /certs /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]

