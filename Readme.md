# **Auto Deploy Hadoop With Docker**

A way to deploy the Hadoop clusters automatically with the help of docker using shell scripts.

The scripts are just a simple demo now and need to be updated to enable the configuration of some important settings, such  as the number or name of clusters, the password for each docker.

## Background

Recently, I have to finish a task that requires me deploying a Hadoop cluster. But it's disgusting for me that it takes a lot of times to install while reading the instruction docs. On the other hand, when I take a mistake and have to reinstall, it's a boring process. Therefore, I try to write some scripts to get away from it.

## Install

If you have install `git` , you can use the following command

```shell
git clone https://github.com/ZDawnG/hadoop-autodeploy-with-docker.git
```

If you don't have it, you can download this repository to your machine and extract it to a folder.

## Usage

The scripts could only run on Linux.

It will provide you a Hadoop-clusters with a cluster-master node and three cluster-slave nodes. The hostnames are listed as follows:

```shell
cluster-master
cluster-slave1
cluster-slave2
cluster-slave3
```

### Install Docker

Before using it, make sure you have finished install docker and you're supposed to run it on Linux.

#### Ubuntu

```shell
sudo apt-get install docker.io
```

#### Others

Waiting to be added

### Deploy Hadoop

You should be in the folder where the `install.sh` in and be `root` user to open our terminal and run the following command

```shell
./install.sh
```

If you have run the scripts and for some reasons want to rebuilt the clusters you should run this command

```shell
./reinstall.sh
```

### Test

After the installation, you can confirm with the following commands

```shell
root@ubuntu> docker exec -it cluster-master /bin/bash
root@cluster-master> hadoop namenode -format
root@cluster-master> start-all.sh
…
root@cluster-master> jps
1256 ResourceManag4r
1258 DataNode
1246 NameNode
1264 NodeManager
1268 SecondaryNameNode
1275 Jps
root@cluster-master> ssh root@cluster-slave1
root@cluster-slave1>jps
1244 DataNode
1250 NodeManager
1255 Jps
```

## To do List

- [ ] add notes to code
- [ ] auto judge Java path
- [ ] add  parameter analysis function
- [ ] add way to configure the number of clusters
- [ ] update the way of install docker
- [ ] remove unused output of console
