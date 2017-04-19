#!/bin/bash
set -e

if [ "$1" = 'freeswitch' ]; then
	chown -R freeswitch:freeswitch /etc/freeswitch
	chown -R freeswitch:freeswitch /var/{run,lib}/freeswitch
	chown -R freeswitch:freeswitch /{db,certs,scripts,recordings,tmp}
	
	if [ -d /docker-entrypoint.d ]; then
		for f in /docker-entrypoint.d/*.sh; do
			[ -f "$f" ] && . "$f"
		done
	fi
	
	exec gosu freeswitch freeswitch -u freeswitch -g freeswitch -c \
		-sounds /sounds -recordings /recordings -conf /etc/freeswitch \
		-certs /certs -db /db -scripts /scripts	-log /tmp
fi

exec "$@"
