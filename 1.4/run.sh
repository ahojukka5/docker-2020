#!/bin/bash

APP_NAME=$exec_bash_exercise

docker run -d --name=$APP_NAME devopsdockeruh/$APP_NAME
docker exec -it $APP_NAME /usr/bin/tail -f ./logs.txt
docker rm --force $APP_NAME

