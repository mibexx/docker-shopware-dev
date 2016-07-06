#!/bin/bash

git clone https://github.com/shopware/shopware.git /var/www/html

chmod -Rf 0777 /var/www/html/var
chmod -Rf 0777 /var/www/html/web
chmod -Rf 0777 /var/www/html/files
chmod -Rf 0777 /var/www/html/media
chmod -Rf 0777 /var/www/html/engine/Shopware/Plugins/Community