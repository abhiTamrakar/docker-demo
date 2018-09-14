#!/bin/bash

# script to init the ruby application

initialize() {
if [ -d /var/www/railsapp/project_management_demo ]; then
  cd /var/www/railsapp/project_management_demo && \
  nohup rails server -b 0.0.0.0 </dev/null &>/dev/null &
  echo -e "starting rails server with pid $!"
else
  echo -e "application dir not found"
fi
}

if [ "$(whoami)" = "root" ]; then
  echo -e "initializing rails app"
  initialize| tee -a /var/log/railsapp.log
else
  echo -e "you were not root"
fi
