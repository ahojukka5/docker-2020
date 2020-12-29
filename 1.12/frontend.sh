#!/bin/bash

APP_NAME="frontend-example-docker"
IMAGE_NAME="$APP_NAME"

build() {
    echo "Building image ..."
    docker build -f Dockerfile.frontend -t $IMAGE_NAME .
}

run() {
    echo "Running image ..."
    docker run --rm -it \
        --name=$APP_NAME \
        -p 5000:5000 \
        $IMAGE_NAME $@
}

action=$1
shift 1
$action "$@"

