# vim:set ft=dockerfile:
FROM webitel/freeswitch-base

# Install FreeSWITCH with vanilla config
RUN apt-get -y --quiet update && apt-get -y --quiet upgrade \
    && apt-get -y --quiet install freeswitch-meta-vanilla \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

RUN mkdir -p /docker-entrypoint.d /logs /certs /sounds /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]
