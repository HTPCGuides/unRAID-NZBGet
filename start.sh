#!/bin/bash
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /home nobody
chown -R nobody:users /home

if [[ ! -f /config/nzbget.conf ]]; then 
	cp /opt/nzbget/nzbget.conf /config/nzbget.conf
	sed -i -e "s#\(WebDir=\).*#\1/opt/nzbget/webui#g" /config/nzbget.conf
	sed -i -e 's#\(ConfigTemplate=\).*#\1/opt/nzbget/webui/nzbget.conf.template#g' /config/nzbget.conf
	sed -i -e "s#\(LogFile=\).*#\1/config/nzbget.log#g" /config/nzbget.conf
fi

if [[ ! -f /config/nzbget.log ]]; then
	touch /config/nzbget.log
fi

chown -R nobody:users /config /opt/nzbget

tail -f /config/nzbget.log

sh /sbin/setuser nobody /opt/nzbget/nzbget -D -c /config/nzbget.conf