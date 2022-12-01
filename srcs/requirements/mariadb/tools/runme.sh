#!/bin/bash

service mysql start
sleep 5

mysql << EOF
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_PSW}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' with grant option;
    FLUSH PRIVILEGES;
EOF

mysqladmin -u root password $ROOT_PASSWORD
service mysql stop
mysqld_safe