#!/bin/sh
#/etc/init.d/redisInfoProbe

NAME=redisInfoProbe
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
RUNDIR=/home/ubuntu/redisInfoProbe
DAEMON=$RUNDIR/run.sh
DAEMON_ARGS=
USER=ubuntu
GROUP=ubuntu
PIDDIR=/var/run
PIDNAME=$NAME.pid
PIDFILE=$PIDDIR/$PIDNAME

case "$1" in
start)
  if [ -f $PIDFILE ]
  then
    echo Already running with PID `cat $PIDFILE`
  else
    if start-stop-daemon --start --pidfile $PIDFILE --chdir $RUNDIR --background --make-pidfile --chuid $USER:$GROUP --exec $DAEMON -- $DAEMON_ARGS
    then
      echo ok
    else
      echo start failed
    fi
  fi
  ;;
stop)
  if [ -f $PIDFILE ]
  then
    PID=`cat $PIDFILE`
    #start-stop-daemon --stop --signal 9 --pidfile $PIDFILE
    PIDS="$PID `ps -ef| awk '$3 == '$PID' { print $2 }'`"
    for i in $PIDS
    do
      echo killing $i
      kill -9 $i
    done
    rm -f $PIDFILE
  else
    echo $PIDFILE not found
  fi
  ;;
restart)
  ${0} stop
  ${0} start
  ;;
*)
  echo "Usage: /etc/init.d/$NAME {start|stop|restart}"
  exit 1
  ;;
esac

exit 0
