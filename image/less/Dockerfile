FROM        ubuntu:13.10

RUN apt-get update -y

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update -y
RUN apt-get install nodejs -y

RUN mkdir /code

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
