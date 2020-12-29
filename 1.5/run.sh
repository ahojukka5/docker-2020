#!/bin/bash

docker run --rm -it --name=ex1.4 -v ${PWD}:/app ubuntu:16.04 /app/script.sh

