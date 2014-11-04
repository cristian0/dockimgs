FROM        ubuntu:13.10

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update -y

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get install nodejs ruby gem git -y

RUN gem install sass -v 3.3.9
RUN gem install sass-globbing
RUN gem install sass-media_query_combiner

RUN npm install -g grunt
RUN npm install -g grunt-cli
RUN npm config set prefix /usr/local
RUN npm install -g bower

RUN mkdir /code

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
