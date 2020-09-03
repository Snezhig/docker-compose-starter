#!/bin/bash

ENV_FILE=.env

if [ -f "$ENV_FILE" ]; then
  echo "The .env file already exists."
  read -p "Would you like to remove it? (Y|N): " -i 'N' -e remove_env_file
  if [ "${remove_env_file^^}" == 'Y' ]; then
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

cd docker && mkdir -p "logs"
cd "logs" && mkdir -p {"supervisor","tmp","mysql","nginx","php"}
cd "tmp" && mkdir -p "php_sessions" && cd ../..