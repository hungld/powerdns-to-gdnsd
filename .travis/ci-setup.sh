#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/musl/bin:$HOME/bin

#save the current dir for later
ORIG_PWD=$PWD

echo "Creating the PowerDNS Database and User"
mysql --host=localnode --user=root  << EOF
CREATE DATABASE powerdns character set utf8;
GRANT ALL ON powerdns.* TO 'powerdns'@'%' IDENTIFIED BY '8wksjehkaj';
FLUSH PRIVILEGES;
EOF

echo "Importing the PowerDNS mysql schema"
mysql --host=localnode --user=root --database=powerdns < "$PWD/.travis/powerdns/schema.mysql.sql"