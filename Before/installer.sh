#!/bin/bash
#current user login
export HOME_USER=user
 
. /etc/lsb-release
 
sudo cat > /etc/apt/sources.list <<EOF
#------------------------------------------------------------------------------#
#                            OFFICIAL UBUNTU REPOS                             #
#------------------------------------------------------------------------------#


###### Ubuntu Main Repos
deb http://ubuntu.volia.net/ubuntu/ $DISTRIB_CODENAME main restricted universe multiverse 
deb-src http://ubuntu.volia.net/ubuntu/ $DISTRIB_CODENAME main restricted universe multiverse 

###### Ubuntu Update Repos
deb http://ubuntu.volia.net/ubuntu/ $DISTRIB_CODENAME-security main restricted universe multiverse 
deb http://ubuntu.volia.net/ubuntu/ $DISTRIB_CODENAME-updates main restricted universe multiverse 
deb-src http://ubuntu.volia.net/ubuntu/ $DISTRIB_CODENAME-security main restricted universe multiverse 

###### Ubuntu Partner Repo
deb http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner
deb-src http://archive.canonical.com/ubuntu $DISTRIB_CODENAME partner

###### Ubuntu Extras Repo
deb http://extras.ubuntu.com/ubuntu $DISTRIB_CODENAME main
deb-src http://extras.ubuntu.com/ubuntu $DISTRIB_CODENAME main

#------------------------------------------------------------------------------#
#                           UNOFFICIAL UBUNTU REPOS                            #
#------------------------------------------------------------------------------#


###### 3rd Party Binary Repos

#### Kubuntu Beta Backports PPA - https://launchpad.net/~kubuntu-ppa/+archive/beta
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb http://ppa.launchpad.net/kubuntu-ppa/beta/ubuntu $DISTRIB_CODENAME main

#### Kubuntu Updates PPA - https://edge.launchpad.net/~kubuntu-ppa/+archive/ppa
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu $DISTRIB_CODENAME main 


####### 3rd Party Source Repos

#### Kubuntu Beta Backports PPA (Source) - https://launchpad.net/~kubuntu-ppa/+archive/beta
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb-src http://ppa.launchpad.net/kubuntu-ppa/beta/ubuntu $DISTRIB_CODENAME main

#### Kubuntu Updates PPA (Source) - https://edge.launchpad.net/~kubuntu-ppa/+archive/ppa
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb-src http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu $DISTRIB_CODENAME main 
EOF

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
sudo apt-get update
