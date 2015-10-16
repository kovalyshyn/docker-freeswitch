# vim:set ft=dockerfile:
FROM webitel/freeswitch-base

# Install FreeSWITCH with vanilla config
RUN apt-get -y --quiet update \
    && apt-get -y install freeswitch-all freeswitch-mod-shout \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && apt-get -y --quiet purge freeswitch-music-default freeswitch-sounds-en-us-callie \
    && groupadd -r freeswitch && useradd -r -g freeswitch freeswitch \
    && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/freeswitch/conf \
    && mkdir -p /docker-entrypoint.d /certs /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]
