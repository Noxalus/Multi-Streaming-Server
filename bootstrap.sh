#!/usr/bin/env bash

sudo -s

nginx_path=/usr/bin/nginx
if [ ! -e $nginx_path ]; then
    add-apt-repository ppa:mc3man/trusty-media
    apt-get update
    apt-get install build-essential libpcre3 libpcre3-dev openssl libssl-dev unzip libaio1 ffmpeg -y
    wget http://nginx.org/download/nginx-1.9.5.tar.gz
    wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
    tar -zxvf nginx-1.9.5.tar.gz
    unzip master.zip
    cd nginx-1.9.5
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
    make
    make install

    cd /home/vagrant    

    # Remove downloaded archives
    rm master.zip nginx-1.9.5.tar.gz

    # Remove folder used to build Nginx
    rm -rf nginx-1.9.5 nginx-rtmp-module-master


    # Create a symlink for nginx
    ln -fs /usr/local/nginx/sbin/nginx $nginx_path
fi

# Copy nginx conf files
cp -R /vagrant/nginx/html /usr/local/nginx
cp /vagrant/nginx/conf/nginx.conf /usr/local/nginx/conf

# TODO: Launch a script to replace variables in Nginx conf file

# Stop Nginx if it's running
if [ -e /usr/local/nginx/logs/nginx.pid ]; then
    echo "Stop Nginx server"
    nginx -s stop
fi

# Launch Nginx
nginx
echo "Nginx is ready to use"