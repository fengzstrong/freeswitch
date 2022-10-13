#!/bin/bash
set -e

if [ "$1" = 'freeswitch' ]; then

    chown -R freeswitch:freeswitch /usr/local/freeswitch
    
    if [ -d /docker-entrypoint.d ]; then
        for f in /docker-entrypoint.d/*.sh; do
            [ -f "$f" ] && . "$f"
        done
    fi
    
    exec gosu freeswitch /usr/local/freeswitch/bin/freeswitch -u freeswitch -g freeswitch -nonat -c
fi

exec "$@"
