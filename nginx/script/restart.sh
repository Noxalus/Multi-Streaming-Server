#!/usr/bin/env bash

# Stop Nginx if it's already running
if [ -e /usr/local/nginx/logs/nginx.pid ]; then
    nginx -s stop
fi

# Launch Nginx
nginx

# Make sure Nginx configuration file is correct
/usr/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf

if [[ $? != 0 ]]; then 
	echo "Error: Nginx's configuration file contains some errors."
	exit 1; 
fi

# Make sure Nginx is running or display the error message
if [ -e /usr/local/nginx/logs/nginx.pid ]; then
	echo "Nginx is ready to use."
else
	echo "Nginx is not running, please check the nginx.conf configuration file is correct.\n
		  Please check the content of the /usr/local/nginx/logs/error.log file."
	
	exit 1;
fi