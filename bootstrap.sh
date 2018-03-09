#!/usr/bin/env bash

# Install Nginx with RTMP module
nginx_path=/usr/sbin/nginx
if [ ! -e $nginx_path ]; then
    add-apt-repository ppa:mc3man/trusty-media
    apt-get update
    apt-get install -y build-essential libpcre3 libpcre3-dev openssl libssl-dev unzip libaio1 ffmpeg
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

    # Create a symlink to us nginx as a command
    ln -fs /usr/local/nginx/sbin/nginx $nginx_path

    # Create symlinks for Nginx config files
    rm -rf /usr/local/nginx/html
    ln -fs /vagrant/nginx/html /usr/local/nginx/
    ln -fs /vagrant/nginx/conf/nginx.conf /usr/local/nginx/conf

    chmod 755 /vagrant/nginx/html/*

    # Create new aliases
    echo "alias gonginx='cd /usr/local/nginx'" >> ~/.bashrc

    # Copy Nginx scripts
    cp -rf /vagrant/nginx/script/ /usr/local/nginx

    # Copy nginx script to launch Nginx at startup
    cp -f /vagrant/nginx/init/nginx /etc/init.d/
    
    # Make sure that the script use Unix line endings
    sed -i 's/\r//' /etc/init.d/nginx
    sed -i 's/\r//' /usr/local/nginx/script/restart.sh

    update-rc.d nginx defaults
fi

# Install Node JS
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
apt-get install -y build-essential nodejs git

# Install forever
npm install forever -g

# Copy the Nginx config file watcher script
cp -rf /vagrant/nodejs/nginx-conf-watcher /home/vagrant

# Copy nginx-conf-watcher to watch Nginx config file at startup
cp -f /vagrant/nginx/init/nginx-conf-watcher /etc/init.d/

# Make sure that the script use Unix line endings
sed -i 's/\r//' /etc/init.d/nginx-conf-watcher
    
update-rc.d nginx-conf-watcher defaults

service nginx start
service nginx-conf-watcher start