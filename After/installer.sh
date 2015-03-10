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
 
 
#base utils
sudo apt-get --yes --force-yes install mc htop
 
#system upgrade
sudo apt-get --yes --force-yes upgrade
 
#------------------------------add chrome repo-------------------------------------
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#-----------------------------------------------------------------------------------
 
 
#------------------------------add nodejs repo--------------------------------------
sudo apt-get --yes --force-yes install curl
sudo curl -sL https://deb.nodesource.com/setup | sudo bash -
#-----------------------------------------------------------------------------------
 
 
#---------------------------add charles repo---------------------------------------
wget -q -O - http://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
cat > /etc/apt/sources.list.d/charles.list <<EOF
deb http://www.charlesproxy.com/packages/apt/ charles-proxy main
EOF
#-----------------------------------------------------------------------------------
 
 
 
#------------------------------add SmartGit repo------------------------------------
printf "\n" | sudo add-apt-repository ppa:eugenesan/ppa
#-----------------------------------------------------------------------------------
 
#flash plagin
printf "\n" | sudo add-apt-repository ppa:nilarimogard/webupd8
 
sudo apt-get update
#install all
sudo apt-get --yes --force-yes install iftop iotop terminator google-chrome-stable  apache2 php5 php5-dev php5-curl php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mongo php5-mysqlnd php5-sqlite php-pear php-apc phpunit mysql-workbench mongodb wine smartgithg mysql-server-5.6 nodejs charles-proxy skype freshplayerplugin
 
printf "\n" | sudo pecl install mongo
printf "\n" | sudo pecl install xdebug
#-----------------------------Configurate system--------------------------------------
sudo cat > /etc/php5/mods-available/xdebug.ini  <<EOF
zend_extension=xdebug.so
xdebug.auto_trace = 0
;xdebug.collect_includes = 1
;xdebug.collect_params = 1
;xdebug.collect_return = 1
;xdebug.collect_vars = 1
xdebug.default_enable = 1
;xdebug.dump.SERVER = REMOTE_ADDR,REQUEST_METHOD
;xdebug.dump.SERVER = REMOTE_ADDR,REQUEST_METHOD
;xdebug.dump.COOKIE = ""
;xdebug.dump.FILES = ""
;xdebug.dump.GET = ""
;xdebug.dump.POST = ""
;xdebug.dump.REQUEST = ""
;xdebug.dump.SERVER = ""
;xdebug.dump.SESSION = ""
;xdebug.dump_globals = 1
;xdebug.dump_once = 1
;xdebug.dump_undefined = 1
;xdebug.extended_info = 1
;xdebug.file_link_format = ""
xdebug.idekey = "phpstorm-xdebug"
;xdebug.manual_url = "http://www.php.net"
;xdebug.max_nesting_level = 250
;xdebug.overload_var_dump = 1
;xdebug.profiler_append = 0
xdebug.profiler_enable = 1
;xdebug.profiler_enable_trigger = 1
xdebug.profiler_output_dir="/home/$HOME_USER/Web/debug/profiler/"
xdebug.profiler_output_name = "cachegrind.out.%H%R"
;xdebug.remote_autostart = 0
xdebug.remote_enable = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_host = "localhost"
xdebug.remote_log = "/home/$HOME_USER/Web/debug/xdebug.log"
xdebug.remote_mode = "req"
xdebug.remote_port = 9000
xdebug.cli_color = 1
;xdebug.show_exception_trace = 1
;xdebug.show_local_vars = 1
;xdebug.show_mem_delta = 1
;xdebug.trace_format = 0
;xdebug.trace_options = 0
;xdebug.trace_output_dir = "/home/$HOME_USER/Web/debug/trace/"
;xdebug.trace_output_name = "trace.%H%R"
xdebug.var_display_max_children = 128
xdebug.var_display_max_data = 512
xdebug.var_display_max_depth =10
 
EOF
 
. apache2.sh