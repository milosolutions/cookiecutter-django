#!/bin/bash

alias rs="cd /vagrant; honcho start"
alias test="cd /vagrant; python manage.py test --settings=config.settings.test"

export WORKON_HOME=~/envs
source /usr/local/bin/virtualenvwrapper.sh

workon vagrant
cd /vagrant/
