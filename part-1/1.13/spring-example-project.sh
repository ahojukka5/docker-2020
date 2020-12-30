#!/bin/bash

APP_NAME="spring-example-project"
IMAGE_NAME="$APP_NAME"

build() {
    echo "Building image ..."
    docker build -f Dockerfile -t $IMAGE_NAME .
}

run() {
    echo "Running image ..."
    docker run --rm -it \
        --name=$APP_NAME \
        -p 8080:8080 \
        $IMAGE_NAME $@
}

action=$1
shift 1
$action "$@"

