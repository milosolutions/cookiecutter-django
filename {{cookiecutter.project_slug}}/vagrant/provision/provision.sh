#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

function msg()
{
    echo " ";
    echo "############################################################";
    echo "$1";

    echo " ";
    echo " ";
}

VAGRANT_USER="ubuntu"
VAGRANT_USER_PASS=$VAGRANT_USER
VAGRANT_HOME="/home/$VAGRANT_USER"

#msg "Change user password"
#echo "$VAGRANT_USER:$VAGRANT_USER_PASS" | sudo chpaswd


msg "Copy template files"
apt-get install dos2unix
su - $VAGRANT_USER -c "cp -f /vagrant/vagrant/templates/env.example /vagrant/.env"
dos2unix /vagrant/.env
su - $VAGRANT_USER -c "cp -f /vagrant/vagrant/templates/.bashrc ~/.bashrc"
dos2unix $VAGRANT_HOME/.bashrc
su - $VAGRANT_USER -c "cp -n /vagrant/vagrant/templates/colors.sh ~/colors.sh"
dos2unix $VAGRANT_HOME/colors.sh
su - $VAGRANT_USER -c "cp -n /vagrant/vagrant/templates/rs.sh /vagrant/rs.sh"
dos2unix /vagrant/rs.sh

msg "Installing system packages"
#apt-get update -y
#apt-get upgrade -y
apt-get install -y \
    $(: System packages and tools) \
        build-essential mc git git-flow dos2unix bash-completion libssl-dev redis-server \
    $(: Python dependencies) \
        python3-pip python-pip python3-dev libffi-dev
{% if cookiecutter.use_celery == 'y' -%}
apt-get install -y redis-server
{% endif %}

msg "Installing virtualenv and virtualenvwrapper"
pip install -U pip
pip install virtualenv virtualenvwrapper
