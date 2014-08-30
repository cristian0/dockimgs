dockimgs
========

Stop all containers
------------------------------
docker stop $(docker ps -a -q)


Remove all stopped containers (Attenzione cancella anche i dati dei volumi del container)
------------------------------
docker rm $(docker ps -a -q)


Remove all untagged images
---------------------------
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")


Crea il volume DBDATA che punta a /var/lib/mysql
------------------------------------------------
docker run -v /var/lib/mysql --name DBDATA busybox true

# docker run -i -t -name mysql_data -v /var/lib/mysql busybox /bin/sh
