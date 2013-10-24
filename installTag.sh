#!/bin/sh
apt-get -y --force-yes install python-pip python-dev
pip install psutil redis
cp redisInfoProbeBase.cfg redisInfoProbe.cfg
echo "tags = liberty,probe,$1" >> redisInfoProbe.cfg
cp redisInfoProbe_init.d /etc/init.d/redisInfoProbe
chmod a+x /etc/init.d/redisInfoProbe
update-rc.d redisInfoProbe defaults
/etc/init.d/redisInfoProbe restart
