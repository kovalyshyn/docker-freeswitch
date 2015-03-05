FROM webitel/freeswitch-base

ONBUILD RUN apt-get -y --quiet update \
        && apt-get -y --quiet install libfreeswitch-dev \
        git build-essential autoconf \
	automake libtool pkg-config