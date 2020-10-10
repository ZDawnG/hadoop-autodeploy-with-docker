#!/bin/bash

cd /opt
curl -O http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
tar -xzf hadoop-3.2.1.tar.gz
ln -s hadoop-3.2.1 hadoop

cat /root/path.txt>>/root/.bashrc
