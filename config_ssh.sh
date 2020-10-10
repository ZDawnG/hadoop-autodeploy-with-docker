#!/bin/bash

yum -y install sshpass

/root/sshpass -p "dawn" ssh root@cluster-slave1 'mkdir ~/.ssh'
/root/sshpass -p "dawn" scp ~/.ssh/authorized_keys root@cluster-slave1:~/.ssh
/root/sshpass -p "dawn" ssh root@cluster-slave2 'mkdir ~/.ssh'
/root/sshpass -p "dawn" scp ~/.ssh/authorized_keys root@cluster-slave2:~/.ssh
/root/sshpass -p "dawn" ssh root@cluster-slave3 'mkdir ~/.ssh'
/root/sshpass -p "dawn" scp ~/.ssh/authorized_keys root@cluster-slave3:~/.ssh
