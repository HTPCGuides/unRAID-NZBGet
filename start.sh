#!/bin/bash

if [[ ! -f /config/nzbget.conf ]]; then 
	cp /opt/nzbget/nzbget.conf /config/nzbget.conf
fi

if [[ ! -f /config/nzbget.log ]]; then
	touch /config/nzbget.log
fi

/opt/nzbget/nzbget -c /config/nzbget.conf -D