#! /bin/bash
curl -o phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
tar -xvf phpmyadmin.tar.gz -C /var/www/html/ &> /dev/null && rm -f phpmyadmin.tar.gz && mv ./config.inc.php var/www/html/phpMyAdmin-4.9.0.1-all-languages/
tar -xvf wordpress.tar.gz -C /var/www/html/ &> /dev/null && rm -f wordpress.tar.gz && mv ./wp-config.php var/www/html/wordpress/
if [ "$autoindex" == "off" ]
then
	ln -s /etc/nginx/sites-available/conf-nginx /etc/nginx/sites-enabled/ 
	echo "Starting without Autoindex"
else
	ln -s /etc/nginx/sites-available/conf-nginx-auto /etc/nginx/sites-enabled/ 
	echo "Starting with Autoindex"
fi
service nginx start
service php7.3-fpm start
service mysql start
service nginx status
service php7.3-fpm status
service mysql status
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password && echo "DATABASE CREATE" || echo "DATABASE FAILED"
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
bash
sleep infinity
