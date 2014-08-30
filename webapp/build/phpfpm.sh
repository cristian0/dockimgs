#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
exec /etc/init.d/php5-fpm start >>/var/log/php5-fpm.log 2>&1

