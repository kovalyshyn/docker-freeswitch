# vim:set ft=dockerfile:
# Install FreeSWITCH with vanilla config
FROM webitel/freeswitch-base
LABEL maintainer="Vitaly Kovalyshyn"

RUN apt -y --quiet update && apt install -y --quiet freeswitch-meta-all \
    && cp -a /usr/share/freeswitch/conf/vanilla /etc/freeswitch \
    && rm -rf /usr/share/freeswitch/conf \
    && mkdir -p /docker-entrypoint.d /certs /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch \
    && apt clean && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]
