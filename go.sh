#!/bin/bash
echo "--> Docker stop and remove running containers:"
docker stop magentoapp mysql-server redis-server
docker rm magentoapp mysql-server redis-server

echo "--> Start Mysql server container:"
# start mysql console
docker run --name mysql-server --volumes-from DBDATA -p 3306:3306 -d -t cristian0/mysql

echo "--> Start Redis server container:"
# start redis console
docker run --name redis-server -p 6379:6379 -d -t cristian0/redis 

echo "--> Start Web server container:"
# start magento
docker run --name magentoapp --link mysql-server:db --link redis-server:redis -v /home/cristiano/dev/app:/var/www -p 22 -p 80:80 -t -d cristian0/webapp


echo "--> Container started:"
# ritorno l'elenco dei container con ipaddress
docker inspect --format '{{.Name}}: {{ .NetworkSettings.IPAddress }}' $(docker ps -q)
