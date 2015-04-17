# vim:set ft=dockerfile:
FROM webitel/freeswitch-base

# Install FreeSWITCH with vanilla config
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y --quiet update \
	&& apt-get -y --quiet install freeswitch \
	freeswitch-mod-commands \
	freeswitch-mod-conference \
	freeswitch-mod-curl \
	freeswitch-mod-db \
	freeswitch-mod-dialplan-xml \
	freeswitch-mod-cdr-pg-csv \
	freeswitch-mod-xml-cdr \
	freeswitch-mod-xml-curl \
	freeswitch-mod-cdr-mongodb \
	freeswitch-mod-event-socket \
	freeswitch-mod-event-multicast \
	freeswitch-mod-event-zmq \
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
	freeswitch-mod-h26x \
	freeswitch-mod-g723-1 \
	freeswitch-mod-g729 \
	freeswitch-mod-vp8 \
	freeswitch-mod-opus \
	freeswitch-mod-isac \
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
	freeswitch-mod-fifo \
	freeswitch-mod-callcenter \
	freeswitch-mod-lcr \
	freeswitch-mod-blacklist \
	freeswitch-mod-logfile \
	freeswitch-timezones \
	freeswitch-conf-vanilla \
	&& cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch

# Purge && clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND dialog
COPY docker-entrypoint.sh /

RUN mkdir -p /docker-entrypoint.d /logs /certs /sounds /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch

VOLUME ["/sounds", "/certs", "/db", "/recordings", "/scripts", "/etc/freeswitch"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]
