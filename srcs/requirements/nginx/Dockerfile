FROM debian:buster

EXPOSE 443

RUN apt-get update && apt-get install -y \
    nginx \
    openssl

RUN rm -rf /etc/nginx/sites-available/default 
RUN rm -rf /etc/nginx/sites-enabled/default

COPY ./conf/nginx.conf /etc/nginx/sites-available/conf
RUN ln -s /etc/nginx/sites-available/conf /etc/nginx/sites-enabled/conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/nginx.key -out /etc/ssl/nginx.crt -subj "/C=LV/ST=Russia Region/L=KAZAN/O=Bobo/OU=IT/CN=mshad"

CMD ["nginx", "-g", "daemon off;"]