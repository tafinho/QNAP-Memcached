#!/bin/sh
### BEGIN INIT INFO
# Provides:          <NAME>
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       <DESCRIPTION>
### END INIT INFO


QPKG_NAME=Memcached
RUNAS=httpdusr
CONF=/etc/config/qpkg.conf
QPKG_DIR=$(/sbin/getcfg $QPKG_NAME Install_Path -d "" -f $CONF)
MEMCACHECONF=$QPKG_DIR/memcached.conf
SCRIPT=$QPKG_DIR/memcached
PIDFILE=/var/run/$QPKG_NAME.pid

WEB_SHARENAME=$(/sbin/getcfg SHARE_DEF defWeb -d Web -f /etc/config/def_share.info)
SYS_WEB_PATH=$( /sbin/getcfg Qweb path -f /etc/config/smb.conf)
QPKG_WWW=$QPKG_DIR
SYS_WWW=$SYS_WEB_PATH/QPKG_NAME

source $MEMCACHECONF

start() {
	ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF) 
   	if [ "$ENABLED" != "TRUE" ]; then
   		echo "$QPKG_NAME is disabled."
   		exit 1 
    fi
	if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
	  echo 'Service already running' >&2
	  return 1
	fi
	echo 'Starting service...' >&2
	$SCRIPT -d -m $RAM -p $PORT -u $RUNAS -P $PIDFILE
	echo 'Service started' >&2
	ln -nfs $QPKG_WWW/Web $SYS_WWW
}

stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    return 1
  fi
  echo 'Stopping service…' >&2
  kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
  echo 'Service stopped' >&2
}


case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  uninstall)
    uninstall
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|uninstall}"
esac
