#!/bin/bash

alias rs="/vagrant/rs.sh"

export WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh

workon vagrant
cd /vagrant/
