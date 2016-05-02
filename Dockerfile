# vim:set ft=dockerfile:
# Install FreeSWITCH with vanilla config
FROM webitel/freeswitch-base
MAINTAINER Vitaly Kovalyshyn "vitaly@kovalyshyn.pp.ua"

RUN apt-get -y --quiet update \
    && apt-get -y --quiet --force-yes install freeswitch-all \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && rm -rf /usr/share/freeswitch/conf \
    && mkdir -p /docker-entrypoint.d /certs /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]

