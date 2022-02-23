#! /bin/sh

if [ $# -eq 0 ];then
   echo "Use ./autoindex.sh with on or off"
   exit
fi
if [ $1 = "on" ]; then
	rm -rf /etc/nginx/sites-enabled/conf-nginx
	ln -s /etc/nginx/sites-available/conf-nginx-auto /etc/nginx/sites-enabled/
	echo "Auto index ON !"
	service nginx restart
elif [ $1 = "off" ]; then
	rm -rf /etc/nginx/sites-enabled/conf-nginx-auto
	ln -s /etc/nginx/sites-available/conf-nginx /etc/nginx/sites-enabled/
	echo "Auto index OFF !"
	service nginx restart
else
	echo "Use ./autoindex.sh with on or off"
fi
