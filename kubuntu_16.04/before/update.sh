#!/bin/bash

sudo cat > /etc/apt/sources.list <<EOF

deb http://ug.archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse 
deb http://ug.archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse 
deb http://ug.archive.ubuntu.com/ubuntu/ xenial-proposed main restricted universe multiverse 
deb http://ug.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse 
deb-src http://ug.archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse 
deb-src http://ug.archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse 
deb-src http://ug.archive.ubuntu.com/ubuntu/ xenial-proposed main restricted universe multiverse 
deb-src http://ug.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse 
EOF
apt update
