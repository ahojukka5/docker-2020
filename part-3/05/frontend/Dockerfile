FROM node:14-alpine

# Setup node user and workdir
USER node
WORKDIR /home/node

# Define environment variables
ENV NODE_ENV=production
ENV API_URL=http://localhost:8000

# Download sources to /home/node/app
RUN wget https://github.com/docker-hy/frontend-example-docker/archive/master.tar.gz -O - | tar zxv
RUN mv frontend-example-docker-master app

# Install dependencies
WORKDIR /home/node/app
RUN npm install --production

# Build project
RUN npm run build

# Install server
# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#global-npm-dependencies
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
RUN npm install -g serve

# Defaults
EXPOSE 5000

ENTRYPOINT ["/home/node/.npm-global/bin/serve"]
CMD ["-n", "-s", "-l", "5000", "dist"]
