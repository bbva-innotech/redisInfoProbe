#!/bin/sh
apt-get -y install python-pip python-dev
pip install psutil redis
cp redisInfoProbeBase.cfg redisInfoProbe.cfg
echo "tags = liberty,probe,`hostname`" >> redisInfoProbe.cfg
cp redisInfoProbe_init.d /etc/init.d/redisInfoProbe
chmod a+x /etc/init.d/redisInfoProbe
update-rc.d redisInfoProbe defaults
/etc/init.d/redisInfoProbe restart
