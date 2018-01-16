#!/bin/bash

if [[ $1 == 'start' ]]; then
	sed "s/www-data/root/g" -i /etc/nginx/nginx.conf
	/usr/sbin/nginx -c /etc/nginx/nginx.conf -g 'daemon off;'

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
