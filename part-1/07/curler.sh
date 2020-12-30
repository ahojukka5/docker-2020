#!/bin/bash

APP_NAME="curler"
IMAGE_NAME="$APP_NAME"

build() {
    echo "Building image ..."
    docker build -t $IMAGE_NAME .
}

run() {
    echo "Running image ..."
    docker run --rm -it --name=$APP_NAME $IMAGE_NAME $@
}

action=$1
shift 1
$action "$@"

