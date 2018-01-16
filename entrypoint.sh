#!/bin/bash

if [[ $1 == 'start' ]]; then
	sed "s/www-data/root/g" -i /etc/nginx/nginx.conf
	if [[ -e /var/www/html/nginx.conf ]]; then
		rm -f /etc/nginx/sites-enabled/default
		ln -s /var/www/html/nginx.conf /etc/nginx/sites-enabled/site.conf
	fi
	/usr/sbin/nginx -c /etc/nginx/nginx.conf -g 'daemon off;'

elif [[ -z $1 ]]; then
	entrypoint.sh start
fi
