#!/usr/bin/env bash

# Stop Nginx if it's running
if [ -e /usr/local/nginx/logs/nginx.pid ]; then
    echo "Stop Nginx server"
    nginx -s stop
fi

# Launch Nginx
nginx
echo "Nginx is ready to use"