FROM ubuntu:14.04
MAINTAINER Mike Bertram <bertram@nexus-netsoft.com>

ADD data/scripts /opt/nexus/scripts

RUN apt-get update && apt-get -y upgrade \
&& apt-get -y install supervisor openssh-server curl vim git ant unzip \
&& mkdir -p /var/run/sshd /var/log/supervisor \
&& echo 'root:nexus123' | chpasswd \
&& sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ADD data/supervisor /etc/supervisor/conf.d

RUN apt-get -y --force-yes install apache2 mysql-server \
&& mkdir -p /var/lock/apache2 /var/run/apache2 \
&& rm -rf /etc/apache2/sites-enabled/* \
&& chmod +x /opt/nexus/scripts/*.sh

ADD data/apache/vhost /etc/apache2/sites-enabled
ADD data/mysql/conf.d /etc/mysql/conf.d
ADD data/ioncube/ioncube_loaders_lin_x86-64_5.1.2.tar.gz /opt/php

RUN rm -rf /var/lib/mysql/ib_logfile* \
&& /opt/nexus/scripts/config-mysql.sh

RUN apt-get -y install software-properties-common \
&& add-apt-repository ppa:ondrej/php5-5.6 \
&& apt-get update && apt-get -y install python-software-properties \
&& apt-get -y --force-yes install libapache2-mod-php5 php5 php5-mysql php5-gd php5-curl \
&& a2enmod php5 \
&& a2enmod rewrite \
&& adduser --disabled-password --gecos "" nexus \
&& echo 'nexus:nexus123' | chpasswd \
&& adduser www-data nexus \
&& rm -rf /var/www/html

ADD data/php/conf.d /etc/php5/apache2/conf.d

RUN mkdir /var/www/log \
&& /opt/nexus/scripts/prepare-shopware.sh
ADD data/shopware/build.properties /var/www/html/build/build.properties
RUN /opt/nexus/scripts/install-shopware.sh

EXPOSE 22 80 3306
CMD ["supervisord", "-n"]