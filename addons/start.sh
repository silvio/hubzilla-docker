#!/bin/bash

[ ! -e /data/htconfig.php ] && touch /data/htconfig.php
ln -sf /data/htconfig.php /hubzilla/.htconfig.php
chmod -R 0777 /data/htconfig.php

if [ ! -e /data/store ]; then
        mkdir /data/store
        ln -sf /data/store /hubzilla/store
        mkdir -p '/data/store/[data]/smarty3'
        chmod -R 0777 /data/store
else
        sed -i "s/###HUBZILLAINTERVAL###/${HUBZILLAINTERVAL}/" /hubzilla-cron.txt
        crontab /hubzilla-cron.txt
fi



IP="$(ip a show "eth0" | grep 'inet' | cut -d/ -f1 | awk '{print $2}')"

sed -i "s/###SERVERNAME###/${IP}/" /etc/nginx/conf.d/default.conf

nginx
php-fpm

tail -F /var/log/*.log /var/log/nginx/*.log
