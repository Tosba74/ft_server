FROM debian:buster

WORKDIR .

COPY /srcs .

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y nginx ssl-cert mariadb-server curl php7.3-fpm php7.3-mysql
RUN rm ./etc/nginx/sites-enabled/default &&	cp -pr ./conf-nginx-auto /etc/nginx/sites-available/ && cp -pr ./conf-nginx /etc/nginx/sites-available/

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["bash", "setup.sh"]

