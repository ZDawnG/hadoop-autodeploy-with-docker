#!/bin/bash

cat >/etc/ansible/hosts<<EOF
[cluster]
cluster-master
cluster-slave1
cluster-slave2
cluster-slave3

[master]
cluster-master

[slaves]
cluster-slave1
cluster-slave2
cluster-slave3
EOF

cat >/etc/hosts<<EOF
127.0.0.1 localhost
10.0.0.2 cluster-master
10.0.0.3 cluster-slave1
10.0.0.4 cluster-slave2
10.0.0.5 cluster-slave3
EOF

cat >>/root/.bashrc<<EOF
:>/etc/hosts
cat >>/etc/hosts<<END
127.0.0.1 localhost
10.0.0.2 cluster-master
10.0.0.3 cluster-slave1
10.0.0.4 cluster-slave2
10.0.0.5 cluster-slave3
END
EOF

