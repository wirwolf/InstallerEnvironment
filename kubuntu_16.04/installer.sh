
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

#------------------------------------------------------------------------------#
#                           UNOFFICIAL UBUNTU REPOS                            #
#------------------------------------------------------------------------------#


###### 3rd Party Binary Repos

#### Google Chrome Browser - http://www.google.com/linuxrepositories/
## Run this command: wget -q https://dl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main

#### Kubuntu Backports PPA - https://edge.launchpad.net/~kubuntu-ppa/+archive/backports
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial main

#### Oracle Java (JDK) Installer PPA - http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
deb http://ppa.launchpad.net/webupd8team/java/ubuntu vivid main

#### VirtualBox - http://www.virtualbox.org
## Run this command: wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc -O- | sudo apt-key add -
deb http://download.virtualbox.org/virtualbox/debian xenial contrib

#### Wine PPA - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 883E8688397576B6C509DF495A9A06AEF9CB8DB0
deb http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu xenial main


####### 3rd Party Source Repos

#### Kubuntu Backports PPA (Source) - https://edge.launchpad.net/~kubuntu-ppa/+archive/backports
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
deb-src http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial main

#### Oracle Java (JDK) Installer PPA (Source) - http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu vivid main

#### Wine PPA (Source) - https://launchpad.net/~ubuntu-wine/+archive/ppa/
## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 883E8688397576B6C509DF495A9A06AEF9CB8DB0
deb-src http://ppa.launchpad.net/ubuntu-wine/ppa/ubuntu xenial main

EOF
sudo apt update


wget -q https://dl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 883E8688397576B6C509DF495A9A06AEF9CB8DB0
