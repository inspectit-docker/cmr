#!/bin/sh
if [ ${BUFFER_SIZE+x} ];then
	sed -i "s/Xmn512/Xmn$(expr $BUFFER_SIZE / 3)/" startup.sh
	sed -i "s/Xms1536/Xms$BUFFER_SIZE/" startup.sh
	sed -i "s/Xmx1536/Xmx$BUFFER_SIZE/" startup.sh
fi
exec sh startup.sh

