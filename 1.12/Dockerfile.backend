FROM node:12-alpine

RUN apk update && apk add git

RUN git clone https://github.com/docker-hy/backend-example-docker.git /app

WORKDIR /app

RUN npm install --production

ENV NODE_ENV=production
ENV FRONT_URL=http://localhost:5000

ENTRYPOINT ["npm", "start"]

