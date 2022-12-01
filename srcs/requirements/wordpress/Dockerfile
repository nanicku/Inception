FROM debian:buster

EXPOSE 9000

RUN apt-get -y update && apt-get install -y wget \
	php7.3 php-fpm php-mysql mariadb-client \
	redis \
	unzip 

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
	mv ./wordpress/* ./ && \
    rm -rf wordpress latest.zip
RUN chmod -R 0777 ./wp-content/

WORKDIR /var/www/wordpress	

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod a+x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/wordpress
COPY /conf/www.conf /etc/php/7.3/fpm/pool.d
COPY /tools/wp_start.sh /etc/php/7.3

CMD ["sh", "/etc/php/7.3/wp_start.sh"]