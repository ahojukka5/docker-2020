FROM node:12-alpine

RUN apk update && apk add git

RUN git clone https://github.com/docker-hy/frontend-example-docker.git /app

WORKDIR /app

RUN npm install --production

RUN npm install -g serve

RUN npm run build

ENV NODE_ENV=production

ENTRYPOINT ["/usr/local/bin/serve"]
CMD ["-n", "-s", "-l", "5000", "dist"]

