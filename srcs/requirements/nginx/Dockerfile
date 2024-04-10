FROM debian:bullseye

#------------------------------
RUN     apt update
RUN     apt-get install -y nginx
RUN     mkdir -p /etc/nginx/ssl 
RUN    apt install openssl -y  
# RUN    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mel-kouc.42.fr/UID=mel-kouc"
RUN    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=$HOSTNAME.fr/UID=$ID"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]