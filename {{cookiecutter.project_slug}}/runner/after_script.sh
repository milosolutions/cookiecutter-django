#!/bin/bash
$HOME/envs/{{ project_name }}/bin/coverage report

git clean -f
sudo -u postgres dropdb {{ project_name }}
rm -rf $HOME/envs/{{ project_name }}
