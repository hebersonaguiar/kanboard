#!/bin/bash

set -e

help() {
    echo "Usage: docker run -dti -e DB_DRIVER=VALUE  -e DB_USERNAME=VALUE -e DB_PASSWORD=VALUE -e DB_HOSTNAME=VALUE -e DB_NAME=VALUE -v $(pwd)/kanboard:/var/www/htnl/kanboard container_name:tag" >&2
    echo
    echo "   DB_DRIVER          database driver "
    echo "   DB_USERNAME        database username"
    echo "   DB_PASSWORD        database password"
    echo "   DB_HOSTNAME        database hostname"
    echo "   DB_NAME            database name"
    echo
    exit 1
}

if [ ! -z "$DB_DRIVER" ] || [ ! -z "$DB_USERNAME" ] || [ ! -z "$DB_PASSWORD" ] || [ ! -z "$DB_HOSTNAME" ] || [ ! -z "$DB_NAME" ] ; then

    #CHANGE VARIABLES
    sed -i "s/DBDRIVER/$DB_DRIVER/g" /opt/kanboard/config.php
    sed -i "s/DBUSERNAME/$DB_USERNAME/g" /opt/kanboard/config.php
    sed -i "s/DBPASSWORD/$DB_PASSWORD/g" /opt/kanboard/config.php
    sed -i "s/DBHOSTNAME/$DB_HOSTNAME/g" /opt/kanboard/config.php
    sed -i "s/DBNAME/$DB_NAME/g" /opt/kanboard/config.php

    cp -R /opt/kanboard /var/www/html
    chown -R www-data. /var/www/html 
    chmod 0777 -R /var/www/html/kanboard

else
    echo "Please enter the required data!"
    help

fi

exec "$@"

