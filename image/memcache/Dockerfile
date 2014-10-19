FROM phusion/baseimage:latest
MAINTAINER Cristiano <cristiano@eboox.it>

ENV HOME /root

CMD ["/sbin/my_init"]

RUN apt-get update

# Install Memcached
RUN apt-get install -y memcached

RUN mkdir /etc/service/memcached
ADD build/memcached.sh /etc/service/memcached/run
RUN chmod +x /etc/service/memcached/run

# Port to expose (default: 11211)
EXPOSE 11211

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
