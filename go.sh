#!/bin/bash

#crea il volume DBDATA che punta a /var/lib/mysql
#docker run -v /var/lib/mysql --name DBDATA busybox true

# start mysql console
#gnome-terminal -e "docker.io run --name mysql -p 3306:3306 -t -i --rm --volumes-from DBDATA cristian0/mysql" 
docker.io run --name mysql -p 3306:3306 -t -i -d --volumes-from DBDATA cristian0/mysql

#sleep 6

# start lep
#gnome-terminal -e "docker.io run --name webapp --link mysql:db -p 22 -p 80:80 -t -i --rm -v /home/cristiano/dev/app:/var/www cristian0/webapp" 
docker.io run --name webapp --link mysql:db -p 22 -p 80:80 -t -i -d -v /home/cristiano/dev/app:/var/www cristian0/webapp
