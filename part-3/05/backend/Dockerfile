FROM node:14-alpine

# Setup node user and workdir
USER node
WORKDIR /home/node

# Define environment variables
ENV NODE_ENV=production
ENV FRONT_URL=http://localhost:5000

# Download sources to /home/node/app
RUN wget https://github.com/docker-hy/backend-example-docker/archive/master.tar.gz -O - | tar zxv
RUN mv backend-example-docker-master app

# Install dependencies
WORKDIR /home/node/app
RUN npm install --production

# Defaults
EXPOSE 8000

CMD ["npm", "start"]
