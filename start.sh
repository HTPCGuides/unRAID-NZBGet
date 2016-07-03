#!/bin/bash
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /home nobody
chown -R nobody:users /home

if [[ ! -f /config/nzbget.conf ]]; then 
	cp /opt/nzbget/nzbget.conf /config/nzbget.conf
fi

if [[ ! -f /config/nzbget.log ]]; then
	touch /config/nzbget.log
fi

chown -R nobody:users /config /opt/nzbget

tail -f /config/nzbget.log

/opt/nzbget/nzbget -c /config/nzbget.conf -D