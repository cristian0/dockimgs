FROM phusion/baseimage:latest
MAINTAINER Cristiano <cristiano@eboox.it>

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

RUN apt-get update -qq && apt-get install -y mysql-server-5.5

#ssh
RUN apt-get install openssh-server nano -y 
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' |chpasswd

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/run.sh"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
