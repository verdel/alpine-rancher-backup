#!/bin/bash

set -e

if [ "x$DB_ENV_DB_PASS" != "x"  ]; then
  DB_PASS=$DB_ENV_DB_PASS
fi
if [ "x$DB_ENV_DB_USER" != "x"  ]; then
  DB_USER=$DB_ENV_DB_USER
fi
if [ "x$DB_PORT_3306_TCP_ADDR" != "x"  ]; then
  DB_HOST=$DB_PORT_3306_TCP_ADDR
fi
if [ "x$DB_PORT_3306_TCP_PORT" != "x"  ]; then
  DB_PORT=$DB_PORT_3306_TCP_PORT
fi

export DB_PASS
export DB_USER
export DB_HOST
export DB_PORT

if [ "$1" = "backup" ]; then 
  exec /sbin/rancher-mysql-full.sh -h $DB_HOST -u $DB_USER -p $DB_PASS -o /backup  

elif [ "$1" = "restore" ]; then
  if [ -z "$2" ]; then
    exec /sbin/rancher-mysql-restore.sh -h $DB_HOST -u $DB_USER -p $DB_PASS
  else
    exec /sbin/rancher-mysql-restore.sh -h $DB_HOST -u $DB_USER -p $DB_PASS -i /backup/$2
  fi
fi

exec "$@"