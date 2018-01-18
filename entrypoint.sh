#!/bin/bash

if [[ $1 == 'start' ]]; then
	chown -R www-data:www-data /var/www/html/
	/usr/sbin/nginx -c /etc/nginx/nginx.conf -g 'daemon off;'

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
