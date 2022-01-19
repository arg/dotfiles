#!/bin/sh

echo "Initializing users and databases..."
mysql -u root -p$MARIADB_ROOT_PASSWORD --execute \
"
CREATE DATABASE $DB_MYSQL_NAME;
GRANT ALL privileges on $DB_MYSQL_NAME.* TO '$DB_MYSQL_USER'@'%' identified by '$DB_MYSQL_PASSWORD';
FLUSH PRIVILEGES;
"
echo "Done."
