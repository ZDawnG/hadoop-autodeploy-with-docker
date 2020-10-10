#!/bin/bash

yum -y install openssh openssh-server openssh-clients
systemctl start sshd
sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
systemctl restart sshd
yum -y install passwd
echo dawn | passwd root --stdin 

