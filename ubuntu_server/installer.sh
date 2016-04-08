#!/bin/bash

. /etc/lsb-release
 
sudo cat > /etc/apt/sources.list <<EOF
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME main restricted
deb-src http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME universe restricted main multiverse #Added by software-properties
 
## Major bug fix updates produced after the final release of the
## distribution.
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-updates main restricted
deb-src http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-updates universe restricted main multiverse #Added by software-properties
 
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME universe
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-updates universe
 
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME multiverse
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-updates multiverse
 
## Uncomment the following two lines to add software from the 'backports'
## repository.
## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
# deb http://ua.archive.ubuntu.com/ubuntu/ $DISTRIB_CODENAME-backports main restricted universe multiverse
# deb-src http://ua.archive.ubuntu.com/ubuntu/ $DISTRIB_CODENAME-backports main restricted universe multiverse
 
## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
deb http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner
deb-src http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner
 
## This software is not part of Ubuntu, but is offered by third-party
## developers who want to ship their latest software.
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-security main restricted
deb-src http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-security universe restricted main multiverse #Added by software-properties
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-security universe
deb http://ubuntu.volia.net/ubuntu-archive/ $DISTRIB_CODENAME-security multiverse
EOF
sudo apt-get update
 
 
#base utils
sudo apt-get --yes --force-yes install mc htop
 
#system upgrade
sudo apt-get --yes --force-yes upgrade

#------------------------------add nodejs repo--------------------------------------
sudo apt-get --yes --force-yes install curl
curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
#-----------------------------------------------------------------------------------

sudo apt-get update
#install all
sudo apt-get --yes --force-yes install iftop \
iotop \
ncdu \
pv \
nginx \
php5 \
php5-dev \
php5-curl \
php5-imagick \
php5-mcrypt \
php5-memcache \
php5-memcached \
php5-mongo \
php5-mysqlnd \
php5-sqlite \
php-pear \
php-apc \
nodejs \
npm \
mysql-server-5.5 \
mysql-client-5.5 \
rar \
unrar \
php5-xdebug

sudo ln -s "$(which nodejs)" /usr/bin/node
npm install -g grunt  grunt-cli bower jscs jshint

wget https://getcomposer.org/composer.phar
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer


wget https://raw.githubusercontent.com/wirwolf/InstallerEnvironment/master/After/files/.bashrc -O /root/.bashrc
