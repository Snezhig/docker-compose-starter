#!/bin/bash

ENV_FILE=.env
#Check if env file exists and offer to recreate it
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

#Ask user to type base paths
CURRENT_DIR=$PWD
read -p "Type the project name: " -i "$(sed s~-~_~g <<< ${PWD##*/})" -e PROJECT_NAME
sed -ri "s~@YOUR_PROJECT_NAME@~$PROJECT_NAME~" .env

read -p "Type the project path: " -i "$CURRENT_DIR" -e PROJECT_PATH
sed -ri "s~@PATH_TO_PROJECT@~$PROJECT_PATH~" .env

read -p "Type the path to docker data: " -i "$CURRENT_DIR/docker/data" -e PATH_TO_DOCKER_DATA
sed -ri "s~@PATH_TO_DOCKER_DATA@~$PATH_TO_DOCKER_DATA~" .env

read -p "Type the log path: " -i "$CURRENT_DIR/docker/logs" -e LOGS_PATH
sed -ri "s~@PATH_TO_LOGS@~$LOGS_PATH~" .env

read -p "Type database name: " -e DB_NAME
sed -ri "s~@DB_NAME@~$DB_NAME~" .env

read -p "Type database user: " -e DB_USER
sed -ri "s~@DB_USER@~$DB_USER~" .env

read -p "Type database user password: " -e DB_PASSWORD
sed -ri "s~@DB_PASSWORD@~$DB_PASSWORD~" .env

read -p "Type database root password: " -e DB_ROOT_PASSWORD
sed -ri "s~@DB_ROOT_PASSWORD@~$DB_ROOT_PASSWORD~" .env


for DIRECTORY in "supervisor" "tmp" "mysql" "nginx" "php" "tmp/php_sessions"; do
  mkdir -p "$LOGS_PATH/$DIRECTORY"
done

#Create public directory
if [ ! -d 'public' ]; then
  read -p "Create public folder with index.php? " -i 'Y' -e CREATE_PUBLIC
  if [ "${CREATE_PUBLIC^^}" == 'Y' ]; then
    mkdir public && echo '<?php phpinfo();' >public/index.php
  fi
fi