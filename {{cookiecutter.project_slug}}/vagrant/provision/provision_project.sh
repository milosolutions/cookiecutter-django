#!/usr/bin/env bash

VAGRANT_USER="ubuntu"
VAGRANT_HOME="/home/$VAGRANT_USER"


msg "Creating virtualenv and configuring app"
su - $VAGRANT_USER -c "mkdir -p $VAGRANT_HOME/envs \
export WORKON_HOME=$VAGRANT_HOME/envs && \
source /usr/local/bin/virtualenvwrapper.sh && \
mkvirtualenv -p /usr/bin/python3 vagrant"
