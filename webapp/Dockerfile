FROM stackbrew/ubuntu:13.10
MAINTAINER Cristiano <cristiano@eboox.it>

# Update package repositories
# RUN echo "deb http://archive.ubuntu.com/ubuntu/ saucy universe" >> /etc/apt/sources.list
RUN apt-get update

#ssh + supervisord + tools
RUN apt-get install openssh-server supervisor vim nano curl -y 
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' |chpasswd

RUN mkdir -p /var/log/supervisor
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install nginx + php + magento lib
RUN apt-get update
RUN apt-get install nginx php5-fpm php5-cli php5-mysql php5-mcrypt php5-imap php5-gd php5-curl php-apc php5-json -y

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# - configure nginx links
RUN rm /etc/nginx/sites-enabled/default
RUN rm /etc/php5/fpm/php.ini

ADD config/site.conf /etc/nginx/sites-enabled/default
ADD config/php.ini /etc/php5/fpm/php.ini

# Expose the port
EXPOSE 80 22

ENTRYPOINT ["/usr/bin/supervisord"]
