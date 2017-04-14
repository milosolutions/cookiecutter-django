#!/usr/bin/env bash

ROOT_PASS=vagrant

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=vagrant
APP_DB_PASS=vagrant

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=vagrant

###########################################################
# Changes below this line are probably not necessary
###########################################################
print_db_usage () {
  echo "Your MySQL database has been setup and can be accessed on your local machine on the forwarded port (default:
  3306)"
  echo "  Host: localhost"
  echo "  Port: 3306"
  echo "  Database: $APP_DB_NAME"
  echo "  Username: $APP_DB_USER"
  echo "  Password: $APP_DB_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  mysql -uroot -p$ROOT_PASS"
  echo ""
  echo "User access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  mysql -u$APP_DB_USER -p$APP_DB_PASS"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=mysql://$APP_DB_USER:$APP_DB_PASS@localhost:3306/$APP_DB_NAME"
}

export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_PASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_PASS"

sudo apt-get install -y mysql-server python-mysqldb libmysqlclient-dev

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo ""
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  echo ""
  print_db_usage
  exit
else
    echo "CREATE DATABASE $APP_DB_NAME CHARACTER SET utf8mb4" | mysql -uroot -p$ROOT_PASS
    echo "CREATE USER '$APP_DB_USER'@'localhost' IDENTIFIED BY '$APP_DB_PASS'" | mysql -uroot -p$ROOT_PASS
    echo "GRANT ALL ON $APP_DB_NAME.* TO '$APP_DB_USER'@'localhost'" | mysql -uroot -p$ROOT_PASS
    echo "flush privileges" | mysql -uroot -p$ROOT_PASS

    # Tag the provision time:
    date > "$PROVISIONED_ON"
fi

echo "Successfully created MySQL database on virtual machine."
echo ""
print_db_usage

