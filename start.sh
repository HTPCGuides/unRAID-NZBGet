#!/bin/bash
GROUP=nzbgettmp

mkdir -p /config/logs/supervisor

touch /supervisord.log
touch /supervisord.pid
chown nzbget: /supervisord.log /supervisord.pid

# Get the proper group membership, credit to http://stackoverflow.com/a/28596874/249107

TARGET_GID=$(stat -c "%g" /data)
EXISTS=$(cat /etc/group | grep "${TARGET_GID}" | wc -l)

# Create new group using target GID and add nzbget user
if [ "$EXISTS" = "0" ]; then
  groupadd --gid "${TARGET_GID}" "${GROUP}"
else
  # GID exists, find group name and add
  GROUP=$(getent group "$TARGET_GID" | cut -d: -f1)
  usermod -a -G "${GROUP}" nzbget
fi

usermod -a -G "${GROUP}" nzbget

if [[! -f "/config/nzbget.conf"]]; then
	mv -p /opt/nzbget/nzbget.conf /config/nzbget.conf
	sed -i "/DaemonUsername=/c\DaemonUsername=nzbget" /config/nzbget.conf
fi

# Remove previous pid if it exists
rm "${NZBGET_PID}"

/opt/nzbget/nzbget -c /config/nzbget.conf -D