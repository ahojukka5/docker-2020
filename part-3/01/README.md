# Exercise 3.1 - Optimizing the Dockerfile(s)

## Backend code

Let's start from backend code. Initial file is:

```Dockerfile
FROM ubuntu:20.04

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

RUN apt-get update
RUN apt-get -y install git
RUN git clone https://github.com/docker-hy/backend-example-docker.git /app

RUN apt-get -y install npm
RUN npm install --production

ENV NODE_ENV=production
ENV FRONT_URL=http://localhost:5000

EXPOSE 8000

ENTRYPOINT ["npm", "start"]
```

File size is 662 MB:

```text
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
01_backend          latest              7e5d43400dde        4 minutes ago       662MB
```

History is:

```text
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
7e5d43400dde        4 minutes ago       /bin/sh -c #(nop)  ENTRYPOINT ["npm" "start"]   0B                  
be39218fed37        4 minutes ago       /bin/sh -c #(nop)  EXPOSE 8000                  0B                  
d8fbc51df9fa        4 minutes ago       /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B                  
2872108167d0        4 minutes ago       /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
abfb45724456        4 minutes ago       /bin/sh -c npm install --production             15.3MB              
fd69f8832da9        5 minutes ago       /bin/sh -c apt-get -y install npm               445MB               
e712122801d9        7 minutes ago       /bin/sh -c git clone https://github.com/dock…   231kB               
b4916c5a9c20        7 minutes ago       /bin/sh -c apt-get -y install git               102MB               
3801209c5578        13 minutes ago      /bin/sh -c #(nop) WORKDIR /app                  0B                  
11c837136d58        56 minutes ago      /bin/sh -c apt-get update                       26.3MB              
199ed6944e86        56 minutes ago      /bin/sh -c ln -snf /usr/share/zoneinfo/$TZ /…   51B                 
6018357c9186        56 minutes ago      /bin/sh -c #(nop)  ENV TZ=Europe/Helsinki       0B                  
f643c72bc252        5 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
<missing>           5 weeks ago         /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B                  
<missing>           5 weeks ago         /bin/sh -c [ -z "$(apt-get indextargets)" ]     0B                  
<missing>           5 weeks ago         /bin/sh -c set -xe   && echo '#!/bin/sh' > /…   811B                
<missing>           5 weeks ago         /bin/sh -c #(nop) ADD file:4f15c4475fbafb3fe…   72.9MB              
```

**Optimization**: run all commands in a single RUN and remove git, npm and apt
cache after everything is ready. New image:

```Dockerfile
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
    apt-get purge -y --auto-remove git npm && \
    rm -rf .git && \\
    rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV FRONT_URL=http://localhost:5000

EXPOSE 8000

CMD ["npm", "start"]
```

After chaining the commands, size reduces from 662 MB to 593MB.

## Frontend code

Original Dockerfile is:

```Dockerfile
FROM ubuntu:20.04

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

ENV NODE_ENV=production
ENV API_URL=http://localhost:8000

RUN apt-get update
RUN apt-get -y install
RUN git clone https://github.com/docker-hy/frontend-example-docker.git /app
RUN apt-get -y install npm
RUN npm install --production
RUN npm install -g serve
RUN npm run build

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/serve"]
CMD ["-n", "-s", "-l", "5000", "dist"]
```

Initial image size is 900 MB:

```text
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
01_frontend         latest              efa7730eadb2        10 minutes ago      900MB
```

History is:

```text
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
efa7730eadb2        12 minutes ago      /bin/sh -c #(nop)  CMD ["-n" "-s" "-l" "5000…   0B                  
a8916bd8d8cc        12 minutes ago      /bin/sh -c #(nop)  ENTRYPOINT ["/usr/local/b…   0B                  
5eaa0e29f653        12 minutes ago      /bin/sh -c #(nop)  EXPOSE 5000                  0B                  
1bc58832eb03        12 minutes ago      /bin/sh -c npm run build                        35.2MB              
21c4e896bec3        12 minutes ago      /bin/sh -c npm install -g serve                 5.62MB              
3778c96d90d9        12 minutes ago      /bin/sh -c npm install --production             212MB               
33d105d4cf00        13 minutes ago      /bin/sh -c apt-get -y install npm               445MB               
90e30fa7aa6f        15 minutes ago      /bin/sh -c git clone https://github.com/dock…   921kB               
f49918c717dc        15 minutes ago      /bin/sh -c apt-get -y install git               102MB               
252f2ed9edb4        17 minutes ago      /bin/sh -c apt-get update                       26.3MB              
e3a7d0fc1985        30 minutes ago      /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B                  
ebccdfad9305        30 minutes ago      /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
a4fa669b7a41        2 hours ago         /bin/sh -c #(nop) WORKDIR /app                  0B                  
199ed6944e86        2 hours ago         /bin/sh -c ln -snf /usr/share/zoneinfo/$TZ /…   51B                 
6018357c9186        2 hours ago         /bin/sh -c #(nop)  ENV TZ=Europe/Helsinki       0B                  
f643c72bc252        5 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
<missing>           5 weeks ago         /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B                  
<missing>           5 weeks ago         /bin/sh -c [ -z "$(apt-get indextargets)" ]     0B                  
<missing>           5 weeks ago         /bin/sh -c set -xe   && echo '#!/bin/sh' > /…   811B                
<missing>           5 weeks ago         /bin/sh -c #(nop) ADD file:4f15c4475fbafb3fe…   72.9MB
```

**Optimization**: just like with backend, chain all RUN commands to a single command:

```Dockerfile
FROM ubuntu:20.04

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

ENV NODE_ENV=production
ENV API_URL=http://localhost:8000

RUN apt-get update && \
    apt-get -y install git && \
    git clone https://github.com/docker-hy/frontend-example-docker.git /app && \
    apt-get -y install npm && \
    npm install --production && \
    npm install -g serve && \
    npm run build && \
    apt-get purge -y --auto-remove git && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/serve"]
CMD ["-n", "-s", "-l", "5000", "dist"]
```

After chaining commands, new size is

```text
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
01_frontend         latest              b4e982b98ebc        12 minutes ago      831MB
```

Thus image size reduced from 900 MB to 831 MB.
