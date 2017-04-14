#!/bin/bash
$HOME/envs/{{ project_name }}/bin/python3 manage.py migrate --settings=config.settings.runner
$HOME/envs/{{ project_name }}/bin/coverage run manage.py test --settings=config.settings.runner -v 2
