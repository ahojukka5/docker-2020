#!/bin/bash

APP_NAME="backend-example-docker"
IMAGE_NAME="$APP_NAME"

build() {
    echo "Building image ..."
    docker build -f Dockerfile.backend -t $IMAGE_NAME .
}

run() {
    echo "Running image ..."
    touch logs.txt
    docker run --rm -it \
        --name=$APP_NAME \
        -p 8000:8000 \
        -v "$(pwd)/logs.txt:/app/logs.txt" \
        $IMAGE_NAME $@
}

action=$1
shift 1
$action "$@"

