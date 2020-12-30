#!/bin/bash

apt-get update && apt-get install -y curl

echo "Input website:"
read website
echo "Searching.."
sleep 1
curl -L http://$website
