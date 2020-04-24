function deploy_nginx_cluster() 
{
    sudo docker pull centos
    sleep 15
    for idx in 1 2
    do
        parallelrun "$idx" &
    done
}

function parallelrun(){
        sudo docker run -d --restart=always --name=centos$1 -p 808$1:80 centos/systemd:latest 
        sudo docker exec -t centos$1 /bin/bash -c "yum -y update; 
		yum -y install epel-release;
		yum -y install supervisor;
		yum -y install nginx;
		yum -y install haproxy; 
		rm -f /etc/supervisor/conf.d/supervisord.conf;
		rm -f /etc/nginx/nginx.conf;
		rm -f /etc/haproxy/haproxy.cfg;"
	sudo docker cp config/supervisord.conf centos$1:/etc/supervisord.conf;
	sudo docker cp config/nginx.conf centos$1:/etc/nginx/nginx.conf;
	sudo docker cp config/haproxy.cfg centos$1:/etc/haproxy/haproxy.cfg;
	sudo docker exec -t centos$1 /bin/bash -c "cd /usr/sbin; ./nginx; nginx -t"
	sudo docker exec -t centos$1 /bin/bash -c "echo -e '\e[38;5;82mCheck HTTP on centos$1:';
					   curl 'http://127.0.0.1:8081/200';
					   sleep 1;
				           echo -e '\e[38;5;80mVerification Completed.';"
}

deploy_nginx_cluster
