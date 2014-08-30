#/bin/bash
# originale: https://raw.githubusercontent.com/relateiq/docker_public/master/bin/devenv-inner.sh

set -e

mysql_name='mysql-server'
redis_name='redis-server'
magento_name='magento-app'

redis_image='cristian0/redis' 
mysql_image='cristian0/mysql' 
magento_image='cristian0/webapp'

createvol(){
	docker run -v /var/lib/mysql --name DBDATA busybox true
}

start(){

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
		$magento_image)
	echo "Started MAGENTOAPP in container $WEBAPP"

	docker inspect --format '{{.Name}}: {{ .NetworkSettings.IPAddress }}' $(docker ps -q)

}

stop(){
	echo "Stop and remove running containers:"
	docker stop $magento_name $mysql_name $redis_name
	docker rm $magento_name $mysql_name $redis_name
	echo "Stopped!"
}

stopall(){
	docker stop $(docker ps -a -q)
}

#rmall(){
#	docker rm $(docker ps -a -q)
#}

rm(){
	docker rm $(docker ps -a | grep -v "DBDATA" | awk '{print $1}')
}

rmiuntagged(){
	docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

killz(){
	echo "Killing all docker containers:"
	docker ps
	ids=`docker ps | tail -n +2 |cut -d ' ' -f 1`
	echo $ids | xargs docker kill
	echo $ids | xargs docker rm
}

case "$1" in
	restart)
		stop
		start
		;;
	start)
		start
		;;
	stop)
		stop
		;;
	stopall)
		stopall
		;;
	kill)
		killz
		;;
	createvol)
		createvol
		;;
	status)
		docker ps
		;;
	rmiuntagged)
		rmiuntagged
		;;
	rm)
		rm
		;;
	rmall)
		rmall
		;;
	*)
		echo $"Usage: $0 {start|stopall|stop|restart|status|createvol}"
		RETVAL=1
esac
