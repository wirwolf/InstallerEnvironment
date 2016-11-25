
#!/bin/bash
#current user login
export HOME_USER=user
 
. /etc/lsb-release

sudo cat > /etc/apt/sources.list <<EOF

#------------------------------------------------------------------------------#
#                            OFFICIAL UBUNTU REPOS                             #
#------------------------------------------------------------------------------#


###### Ubuntu Main Repos
deb http://mirror.mirohost.net/ubuntu/ xenial main restricted universe multiverse 
deb-src http://mirror.mirohost.net/ubuntu/ xenial main restricted universe multiverse 

###### Ubuntu Update Repos
deb http://mirror.mirohost.net/ubuntu/ xenial-security main restricted universe multiverse 
deb http://mirror.mirohost.net/ubuntu/ xenial-updates main restricted universe multiverse 
deb http://mirror.mirohost.net/ubuntu/ xenial-proposed main restricted universe multiverse 
deb http://mirror.mirohost.net/ubuntu/ xenial-backports main restricted universe multiverse 
deb-src http://mirror.mirohost.net/ubuntu/ xenial-security main restricted universe multiverse 
deb-src http://mirror.mirohost.net/ubuntu/ xenial-updates main restricted universe multiverse 
deb-src http://mirror.mirohost.net/ubuntu/ xenial-proposed main restricted universe multiverse 
deb-src http://mirror.mirohost.net/ubuntu/ xenial-backports main restricted universe multiverse 

EOF
sudo apt update
sudo apt upgrade --yes
