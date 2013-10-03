#!/bin/sh
cp redisInfoProbe_init.d /etc/init.d/redisInfoProbe
chmod a+x /etc/init.d/redisInfoProbe
update-rc.d redisInfoProbe defaults
/etc/init.d/redisInfoProbe start
