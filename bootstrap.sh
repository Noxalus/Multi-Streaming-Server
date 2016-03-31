#!/usr/bin/env bash

sudo -s
apt-get update
apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip -y
wget http://nginx.org/download/nginx-1.9.5.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
tar -zxvf nginx-1.9.5.tar.gz
unzip master.zip
cd nginx-1.9.5
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
make install
/usr/local/nginx/sbin/nginx

# TODO
# copy nginx.conf template
# change variables with sed => sed -i "s/{{YOUTUBE_API_KEY}}/$YOUTUBE_API_KEY/" nginx.conf