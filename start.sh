#!/bin/bash
#usermod -u 99 nobody
#usermod -g 100 nobody
#usermod -d /home nobody
#chown -R nobody:users /home

if [[ ! -f /config/nzbget.conf ]]; then 
	cp /opt/nzbget/nzbget.conf /config/nzbget.conf
fi

if [[ ! -f /config/nzbget.log ]]; then
	touch /config/nzbget.log
fi

#chown -R nobody:users /config /opt/nzbget

sed -i -e "s#\(LogFile=\).*#\1/config/nzbget.logs#g" /config/nzbget.conf

tail -f /config/nzbget.log

/opt/nzbget/nzbget -D -c /config/nzbget.conf -o outputmode=log