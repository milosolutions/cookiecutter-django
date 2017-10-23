#!/bin/sh -e

# Load config
CONFIG="/vagrant/vagrant/templates/env.example"

if [ -f "$CONFIG" ]
then
  . $CONFIG
fi

msg ()
{
    echo " ";
    echo "############################################################";
    echo "$1";
    echo " ";
    echo " ";
}

print_db_usage () {
  echo "Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: 15432)"
  echo "  Host: localhost"
  echo "  Port: 15432"
  echo "  Database: $POSTGRES_DB_NAME"
  echo "  Username: $POSTGRES_USER"
  echo "  Password: $POSTGRES_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$POSTGRES_USER PGPASSWORD=$POSTGRES_PASS psql -h localhost $POSTGRES_DB_NAME"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$POSTGRES_USER:$POSTGRES_PASS@localhost:15432/$POSTGRES_DB_NAME"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$POSTGRES_USER PGPASSWORD=$POSTGRES_PASS psql -h localhost -p 15432 $POSTGRES_DB_NAME"
}


if [ $POSTGRES ]
then

  msg "Installing postgres"

  export DEBIAN_FRONTEND=noninteractive

  PROVISIONED_ON=/etc/vm_provision_on_timestamp
  if [ -f "$PROVISIONED_ON" ]
  then
    echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
    echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
    echo " "
    print_db_usage
  else

    if [ $POSTGRES_VERSION ]
    then
      apt-get install -y "postgresql-$POSTGRES_VERSION" postgresql-contrib libpq-dev
    else
      apt-get install -y "postgresql" postgresql-contrib libpq-dev
      POSTGRES_VERSION=$(pg_config --version | egrep -o '[0-9]{1,}\.[0-9]{1,}')
      apt-get install -y "postgresql-server-dev-$POSTGRES_VERSION"
    fi

    PG_CONF="/etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf"
    PG_HBA="/etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf"
    PG_DIR="/var/lib/postgresql/$POSTGRES_VERSION/main"

    # Edit postgresql.conf to change listen address to '*':
    sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

    # Append to pg_hba.conf to add password auth:
    echo "host    all             all             all                     md5" >> "$PG_HBA"

    # Restart so that all new config is loaded:
    service postgresql restart

    POSTGIS_SQL_PATH=`pg_config --sharedir`/contrib/postgis-2.1
    # Creating the template spatial database.
    cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASS';
ALTER USER $POSTGRES_USER createdb ;
ALTER USER $POSTGRES_USER WITH SUPERUSER;
-- Create the database:
CREATE DATABASE $POSTGRES_DB_NAME WITH OWNER $POSTGRES_USER;
\connect $POSTGRES_DB_NAME;
EOF


    # Tag the provision time:
    date > "$PROVISIONED_ON"

    echo "Successfully created PostgreSQL dev virtual machine."
    echo " "
    print_db_usage
  fi
fi
