#!/bin/sh
if [ ${BUFFER_SIZE+x} ];then
	sed -i "s/Xmn512/Xmn$(expr $BUFFER_SIZE / 3)/" startup.sh
	sed -i "s/Xms1536/Xms$BUFFER_SIZE/" startup.sh
	sed -i "s/Xmx1536/Xmx$BUFFER_SIZE/" startup.sh
fi

if [ -z "$(ls /CMR/config)" ];then
	# Copying original config folder. This is due mounting the config folder to an empty directory with docker `-v` parameter. Fixing issue #2
	cp -ra /CMR/config.orig/* /CMR/config/
fi

if [ -z "$(ls /CMR/ci)" ];then
	# Copying original ci folder. This is due mounting the ci folder to an empty directory with docker `-v` parameter. Fixing issue #2
	cp -ra /CMR/ci.orig/* /CMR/ci/
fi

exec sh startup.sh

