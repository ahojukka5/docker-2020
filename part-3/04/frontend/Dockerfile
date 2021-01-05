FROM ubuntu:20.04

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

# Environment variables
ENV NODE_ENV=production
ENV API_URL=http://localhost:8000

RUN apt-get update && \
    apt-get -y install git && \
    git clone https://github.com/docker-hy/frontend-example-docker.git . && \
    apt-get -y install npm && \
    npm install --production && \
    npm install -g serve && \
    npm run build && \
    apt-get purge -y --auto-remove git && \
    rm -rf /var/lib/apt/lists/*

# Run as a non-root user
RUN useradd -d /app node && chown -R node:node /app
USER node

# Defaults
EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/serve"]
CMD ["-n", "-s", "-l", "5000", "dist"]
