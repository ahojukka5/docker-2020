#!/bin/bash

docker stop nginx1 nginx2 nginx3
docker rm nginx1 nginx2 nginx3
docker image rm nginx:latest

fence='```'

cat > README.md << EOF
# Exercise 1.2

## Outputs

\`docker ps -a\`:

${fence}bash
`docker ps -a`
${fence}

\`docker images\`:

${fence}bash
`docker images`
${fence}

EOF
