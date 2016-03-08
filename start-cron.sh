#!/bin/sh
# start-cron.sh

/usr/sbin/rsyslogd
/usr/sbin/cron
touch /var/log/cron.log
tail -F /var/log/syslog /var/log/cron.log
