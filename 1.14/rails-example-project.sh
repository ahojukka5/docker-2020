#!/bin/bash

APP_NAME="rails-example-project"
IMAGE_NAME="$APP_NAME"

build() {
    echo "Building image ..."
    docker build -f Dockerfile -t $IMAGE_NAME .
}

run() {
    if [ "$1" == "interactive" ]
    then
        echo "Running image in interactive mode ..."
        docker run --rm -it --name=$APP_NAME -p 3000:3000 $IMAGE_NAME
    else
        echo "Running image in background ..."
        docker run -d --name=$APP_NAME -p 3000:3000 $IMAGE_NAME
    fi
}

stop() {
    docker stop $APP_NAME
    docker rm $APP_NAME
}

action=$1
shift 1
$action "$@"

