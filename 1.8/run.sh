#!/bin/sh

docker pull devopsdockeruh/first_volume_exercise

touch logs.txt

docker run --rm -it \
    --name=first_volume_exercise \
    -v "${PWD}/logs.txt:/usr/app/logs.txt" \
    devopsdockeruh/first_volume_exercise

