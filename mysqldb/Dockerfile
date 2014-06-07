FROM stackbrew/ubuntu:12.04
MAINTAINER Cristiano <dabduster@gmail.com>

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
