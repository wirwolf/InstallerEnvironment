#!/bin/bash
#current user login
export HOME_USER=user
 
. /etc/lsb-release
 
sudo cat > /etc/apt/sources.list <<EOF
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME main restricted
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME main restricted
 
## Major bug fix updates produced after the final release of the
## distribution.
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates main restricted
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates main restricted
 
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME universe
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME universe
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates universe
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates universe
 
## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME multiverse
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME multiverse
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates multiverse
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-updates multiverse
 
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
# deb-src http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner
 
## This software is not part of Ubuntu, but is offered by third-party
## developers who want to ship their latest software.
deb http://extras.ubuntu.com/ubuntu $DISTRIB_CODENAME main
deb-src http://extras.ubuntu.com/ubuntu $DISTRIB_CODENAME main
 
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security main restricted
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security main restricted
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security universe
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security universe
deb http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security multiverse
deb-src http://mirror.mirohost.net/ubuntu/ $DISTRIB_CODENAME-security multiverse
EOF
sudo apt-get update