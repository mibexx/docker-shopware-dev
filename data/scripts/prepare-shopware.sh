#!/bin/bash

git clone https://github.com/ShopwareHackathon/shopware.git /var/www/html

cd /var/www/html
git checkout 5.2

chmod -Rf 0777 /var/www/html/var
chmod -Rf 0777 /var/www/html/web
chmod -Rf 0777 /var/www/html/files
chmod -Rf 0777 /var/www/html/media
chmod -Rf 0777 /var/www/html/engine/Shopware/Plugins/Community