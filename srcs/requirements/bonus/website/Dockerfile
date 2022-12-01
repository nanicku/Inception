FROM debian:buster
EXPOSE 8081
RUN apt-get -y update && apt-get install -y php7.3
WORKDIR /var/www/wordpress
COPY ./requirements/bonus/website/tools/* ./
CMD php7.3 --server 0.0.0.0:8081