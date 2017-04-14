#!/usr/bin/env bash

echo "Provision always:"

VAGRANT_USER="ubuntu"

REQUIREMENTS="/vagrant/requirements/vagrant.txt"
if [ -e $REQUIREMENTS ]; then
    su - $VAGRANT_USER -c "\
        workon vagrant && \
        pip install -r /vagrant/requirements/vagrant.txt"
fi

MANAGE="manage.py"
if [ -e $MANAGE ]; then
    su - $VAGRANT_USER -c "\
        workon vagrant && \
    python manage.py migrate"
fi
