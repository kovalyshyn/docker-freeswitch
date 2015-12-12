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
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get -y --quiet update \
    && apt-get -y install freeswitch libfreeswitch1 \
    freeswitch-mod-commands \
    freeswitch-mod-conference \
    freeswitch-mod-curl \
    freeswitch-mod-db \
    freeswitch-mod-dialplan-xml \
    freeswitch-mod-cdr-pg-csv \
    freeswitch-mod-xml-cdr \
    freeswitch-mod-xml-curl \
    freeswitch-mod-event-socket \
    freeswitch-mod-event-multicast \
    freeswitch-mod-hash \
    freeswitch-mod-http-cache \
    freeswitch-mod-local-stream \
    freeswitch-mod-native-file \
    freeswitch-mod-shell-stream \
    freeswitch-mod-lua \
    freeswitch-mod-console \
    freeswitch-mod-say-ru \
    freeswitch-mod-say-en \
    freeswitch-mod-sms \
    freeswitch-mod-sndfile \
    freeswitch-mod-spandsp \
    freeswitch-mod-tone-stream \
    freeswitch-mod-g723-1 \
    freeswitch-mod-g729 \
    freeswitch-mod-vp8 \
    freeswitch-mod-opus \
    freeswitch-mod-dptools \
    freeswitch-mod-expr \
    freeswitch-mod-sofia \
    freeswitch-mod-rtmp \
    freeswitch-mod-rtc \
    freeswitch-mod-verto \
    freeswitch-mod-loopback \
    freeswitch-mod-valet-parking \
    freeswitch-mod-spy \
    freeswitch-mod-voicemail \
    freeswitch-mod-shout \
    freeswitch-mod-fifo \
    freeswitch-mod-callcenter \
    freeswitch-mod-lcr \
    freeswitch-mod-blacklist \
    freeswitch-mod-logfile \
    freeswitch-timezones \
    freeswitch-conf-vanilla \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && rm -rf /usr/share/freeswitch/conf \
    && mkdir -p /docker-entrypoint.d /certs /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]

