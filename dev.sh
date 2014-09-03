#/bin/bash
# originale: https://raw.githubusercontent.com/relateiq/docker_public/master/bin/devenv-inner.sh

set -e

mysql_name='mysql-server'
redis_name='redis-server'
magento_name='magento-app'

redis_image='cristian0/redis' 
mysql_image='cristian0/mysql' 
magento_image='cristian0/webapp'

run(){

	MYSQL=$(docker run \
		-d \
		-t \
		-p 3306:3306 \
		--volumes-from DBDATA \
		--name $mysql_name \
		$mysql_image)
	echo "Started MYSQL in container $MYSQL"

	REDIS=$(docker run \
		-d \
		-t \
		-p 6379:6379 \
		--name $redis_name \
		$redis_image)
	echo "Started REDIS in container $REDIS"

	sleep 1

	WEBAPP=$(docker run \
		-d \
		-t \
		-p 22 \
		-p 80:80 \
		--name $magento_name \
		--link $mysql_name:db \
		--link $redis_name:redis \
		-v /home/cristiano/dev/app:/var/www \
		-v /home/cristiano/dev/docker/logs/webapp:/var/log/nginx \
		$magento_image \
		/sbin/my_init --enable-insecure-key)
	echo "Started MAGENTOAPP in container $WEBAPP"

	docker inspect --format '{{.Name}}: {{ .NetworkSettings.IPAddress }}' $(docker ps -q)

}

start(){
	echo "Start running containers:"
	docker start $mysql_name $redis_name $magento_name
	echo "Started containers:"
	docker inspect --format '{{.Name}}: {{ .NetworkSettings.IPAddress }}' $(docker ps -q)
}

stop(){
	echo "Stop running containers:"
	docker stop $magento_name $mysql_name $redis_name
	echo "OK!"
}

rm(){
	echo "Removing containers:"
	docker rm $magento_name $mysql_name $redis_name
	echo "OK!"
}

rmiuntagged(){
	docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

createvol(){
	docker run -v /var/lib/mysql --name DBDATA busybox true
}

ipaddress(){
	docker inspect --format '{{.Name}}: {{ .NetworkSettings.IPAddress }}' $(docker ps -q)
}

sshin(){
	IPADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)
	echo "Ssh into $IPADDRESS:"
	ssh -i ssh/insecure_key root@$IPADDRESS
}


#rm(){
#	docker rm $(docker ps -a | grep -v "DBDATA" | awk '{print $1}')
#}


case "$1" in
	run)
		run
		;;
	start)
		start
		;;
	stop)
		stop
		;;
	rm)
		rm
		;;
	rmiuntagged)
		rmiuntagged
		;;
	createvol)
		createvol
		;;
	ipaddress)
		ipaddress
		;;
	ssh)
		sshin $2
		;;
	*)
		echo "Usage: $0 {run|start|stop|rm|rmiuntagged|createvol|ipaddress|ssh nomecontainer}"
		RETVAL=1
esac
