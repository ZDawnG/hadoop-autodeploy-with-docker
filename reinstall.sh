#!/bin/bash
#
docker stop `docker ps |  awk 'NR!=1{print $NF}'`
docker rm `docker ps -a |  awk 'NR!=1{print $NF}'`

#create docker and run
#docker pull daocloud.io/library/centos:latest
#docker network create --subnet=10.0.0.0/16 netgroup
docker run -d -p 18088:18088 -p 9870:9870 --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup --name cluster-master -h cluster-master --net netgroup --ip 10.0.0.2 daocloud.io/library/centos /usr/sbin/init
docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup --name cluster-slave1 -h cluster-slave1 --net netgroup --ip 10.0.0.3 daocloud.io/library/centos /usr/sbin/init
docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup --name cluster-slave2 -h cluster-slave2 --net netgroup --ip 10.0.0.4 daocloud.io/library/centos /usr/sbin/init
docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup --name cluster-slave3 -h cluster-slave3 --net netgroup --ip 10.0.0.5 daocloud.io/library/centos /usr/sbin/init

#install and config ssh
hostnames=("cluster-master" "cluster-slave1" "cluster-slave2" "cluster-slave3")
for hostname in ${hostnames[@]}
    do
        docker cp ./install_ssh.sh $hostname:/root/
        docker exec -it $hostname /bin/bash -c "/root/install_ssh.sh"
    done
docker exec -it cluster-master /bin/bash -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''"
docker exec -it cluster-master /bin/bash -c "cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys"

docker cp ./sshpass cluster-master:/root
docker cp ./config_ssh.sh cluster-master:/root/
docker exec -it cluster-master /bin/bash -c "/root/config_ssh.sh"

docker exec -it cluster-master /bin/bash -c "yum -y install epel-release"
docker exec -it cluster-master /bin/bash -c "yum -y install ansible"

docker cp ./config_host.sh cluster-master:/root/
docker exec -it cluster-master /bin/bash -c "/root/config_host.sh"

docker exec -it cluster-master /bin/bash -c 'ansible cluster -m copy -a "src=~/.bashrc dest=~/"'
docker exec -it cluster-master /bin/bash -c 'ansible cluster -m yum -a "name=java-1.8.0-openjdk,java-1.8.0-openjdk-devel state=latest"'

#download and config hadoop
docker cp ./config_env.sh cluster-master:/root/
docker cp ./path.txt cluster-master:/root/
docker exec -it cluster-master /bin/bash -c "/root/config_env.sh"

docker cp ./etc/ cluster-master:/opt/hadoop/
docker cp ./sbin/ cluster-master:/opt/hadoop/

docker cp ./hadoop-dis.yaml cluster-master:/opt/
docker exec -it cluster-master /bin/bash -c "cd /opt && tar -cf hadoop-dis.tar hadoop hadoop-3.2.1"
docker exec -it cluster-master /bin/bash -c "ansible-playbook /opt/hadoop-dis.yaml"

#activate the env variable
docker restart cluster-master

