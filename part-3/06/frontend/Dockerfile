FROM node:14-alpine as build

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

FROM nginx:1.19.6-alpine

# Defaults
EXPOSE 80

COPY --from=build /home/node/app/dist /usr/share/nginx/html
