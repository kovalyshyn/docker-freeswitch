# vim:set ft=dockerfile:
FROM webitel/freeswitch-base:onbuild

# Install mod_bcg729
RUN git clone https://github.com/xadhoom/mod_bcg729.git \
    && cd mod_bcg729 \
    && sed -i 's/opt\/freeswitch\/include/usr\/include/g' Makefile \
    && sed -i 's/opt\/freeswitch\/mod/usr\/lib\/freeswitch\/mod/g' Makefile \
    && mkdir -p /usr/lib/freeswitch/mod \
    && make && make install

# Install FreeSWITCH with vanilla config
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y --quiet update \
	&& apt-get -y --quiet install freeswitch-meta-vanilla freeswitch-mod-shout

# Purge && clean
RUN cd / && rm -rf mod_bcg729 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get purge -y --auto-remove libfreeswitch-dev \
	git build-essential autoconf automake libtool pkg-config

ENV DEBIAN_FRONTEND dialog
COPY docker-entrypoint.sh /

RUN mkdir -p /docker-entrypoint.d /logs /certs /sounds /db /recordings /scripts /var/lib/freeswitch /var/run/freeswitch

VOLUME ["/sounds", "/certs", "/db", "/recordings", "/scripts", "/etc/freeswitch"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]