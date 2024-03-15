FROM debian:buster

# RUN     mkdir -p /etc/nginx/ssl

# RUN apt-get update && apt-get install nginx -y && apt install -y openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mel-kouc.42.fr/UID=mel-kouc"

#------------------------------
RUN     apt update
RUN     apt-get install -y nginx
RUN     mkdir -p /etc/nginx/ssl 
RUN    apt install openssl -y  
RUN    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mel-kouc.42.fr/UID=mel-kouc"

#------------------------------


COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]