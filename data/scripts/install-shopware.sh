#!/bin/bash


/usr/bin/mysqld_safe > /dev/null 2>&1 &

USER="nexus"
PASS="nexus123"

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Connection established?"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done


cd /var/www/html/build
ant build-unit

cd /var/www/html
wget -O test_images.zip http://releases.s3.shopware.com/test_images.zip
unzip test_images.zip

echo "Set permissions"
chown -Rf nexus:nexus /var/www

echo "Delete cache"
chown -Rf nexus:nexus /var/www/html/var/cache/production____REVISION___/*

echo "Generate Theme"
bin/console sw:theme:cache:generate
/var/www/html/var/cache/clear_cache.sh
chown -Rf nexus:nexus /var/www/html/var/cache/production____REVISION___/*
chown -Rf nexus:nexus /var/www
chmod 0777 /var/www/html/config.php
chmod -Rf 0777 /var/www/html/var/cache
chmod -Rf 0777 /var/www/html/web

mysqladmin -uroot shutdown