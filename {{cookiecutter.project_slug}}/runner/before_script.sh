#!/bin/bash
git clean -f
sudo -u postgres createdb -O runner {{ project_name }}
export WORKON_HOME=$HOME/envs && source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv -p /usr/bin/python3 {{ project_name }}
$HOME/envs/{{ project_name }}/bin/pip3 install -r requirements/runner.txt
mv env.runner .env
