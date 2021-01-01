FROM ubuntu:20.04

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

RUN apt-get update && \
apt-get install -y git && \
apt-get install -y nodejs && \
apt-get install -y npm && \
git clone https://github.com/docker-hy/backend-example-docker.git /app && \
npm install --production && \
apt-get purge -y --auto-remove git && \
rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV FRONT_URL=http://localhost:5000

EXPOSE 8000

CMD ["npm", "start"]
