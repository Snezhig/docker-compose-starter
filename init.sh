#!/bin/bash

ENV_FILE=.env

if [ -f "$ENV_FILE" ]; then
  echo "The .env file already exists."
  read -p "Would you like to remove it? (Y|N): " -i 'N' -e REMOVE_ENV_FILE
  if [ "${REMOVE_ENV_FILE^^}" == 'Y' ]; then
    rm .env
    cp .env.template .env
  fi
else
  cp .env.template .env
fi

CURRENT_DIR=$PWD
read -p "Type the project path: " -i "$CURRENT_DIR" -e PROJECT_PATH
sed -ri "s~@PATH_TO_PROJECT@~$PROJECT_PATH~" .env

read -p "Type the log path: " -i "$CURRENT_DIR/docker/logs" -e LOGS_PATH
sed -ri "s~@PATH_TO_LOGS@~$LOGS_PATH~" .env

for DIRECTORY in "supervisor" "tmp" "mysql" "nginx" "php" "tmp/php_sessions"; do
  mkdir -p "$LOGS_PATH/$DIRECTORY"
done

if [ ! -d 'public' ]; then
  read -p "Create public folder with index.php? " -i 'Y' -e CREATE_PUBLIC
  if [ "${CREATE_PUBLIC^^}" == 'Y' ]; then
    mkdir public && echo '<?php phpinfo();' >public/index.php
  fi
fi
