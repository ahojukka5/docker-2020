#!/bin/bash

# set -ea

docker pull nginx:latest

docker run -d --name=nginx1 --restart=always nginx:latest
docker run -d --name=nginx2 --restart=always nginx:latest
docker run -d --name=nginx3 --restart=always nginx:latest

sleep 3

docker stop nginx2
docker stop nginx3

OUTPUT=$(docker ps -a)

cat > README.md << EOF
# Exercise 1.1

## Output

\`\`\`bash
${OUTPUT}
\`\`\`

EOF
