# Exercise 3.7

Let's study Dockerfile for patientor-backend[1][1]. Original file is:

```Dockerfile
FROM node:12-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ENV NODE_ENV=production

EXPOSE 3000

RUN npm run build

ENTRYPOINT ["npm"]

CMD ["start"]
```

Image size is 397MB.

```text
19:09 $ docker history ahojukka5/patientor-backend:latest 
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
bca19c9892b5        38 seconds ago       /bin/sh -c #(nop)  CMD ["start"]                0B                  
9e08e28398ff        38 seconds ago       /bin/sh -c #(nop)  ENTRYPOINT ["npm"]           0B                  
459ae9d3a1ce        38 seconds ago       /bin/sh -c npm run build                        24.3kB              
ac48eb29abfa        43 seconds ago       /bin/sh -c #(nop)  EXPOSE 3000                  0B                  
706c54672b85        43 seconds ago       /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
528ab633103c        43 seconds ago       /bin/sh -c #(nop) COPY dir:d25673af61bf802b4…   1.5MB               
70fd0215f0e4        44 seconds ago       /bin/sh -c npm install                          167MB               
a7aae24e746e        About a minute ago   /bin/sh -c #(nop) COPY multi:b999e8b20aeeb13…   445kB               
952a552595e5        5 days ago           /bin/sh -c #(nop) WORKDIR /app                  0B                  
e09c0033b650        2 weeks ago          /bin/sh -c #(nop)  CMD ["node"]                 0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop) COPY file:238737301d473041…   116B                
<missing>           2 weeks ago          /bin/sh -c apk add --no-cache --virtual .bui…   7.62MB              
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.5      0B                  
<missing>           2 weeks ago          /bin/sh -c addgroup -g 1000 node     && addu…   76.5MB              
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENV NODE_VERSION=12.20.0     0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop) ADD file:8ed80010e443da19d…   5.61MB              
```

Contributions to size comes mainly from `npm install`.

Problems:

- `node_modules` was missing from `.dockerignore`, thus `COPY . .` is copying
  everything from `node_modules`. The same for `build` and `.git`.
- running as a root user
- having development dependencies
- due to how ENTRYPOINT and CMD are used, it's impossible to exec /bin/sh to
  make futher investigations

Fixes:

- **c1f38c0** Add node_modules to .dockerignore (397MB -> 259MB)
- **af9894b** Change base image from node:12-alpine to node:14-alpine (259 MB-> 285MB)
- **0443bdc** Change start command to make exec /bin/sh possible
- **3013422** Handle SIGINT and SIGTERM properly (to make ctrl+c work)
- **ea0efe6** Add build to .dockerignore
- **e018cb4** Run container as a non-root user
- **fda3fe2** Setup multi-stage build (285MB -> 148MB)
- **bb85212** Move npm and install to devDependencies (148MB -> 119MB)
- **fcc0814** Install production node_modules in build stage (119MB -> 118MB)

At this point, docker history is:

```text
21:54 $ docker history ahojukka5/patientor-backend:latest 
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
13bcbaefa9a8        About a minute ago   /bin/sh -c #(nop)  CMD ["node" "src/index.js…   0B                  
bb0cb820a851        About a minute ago   /bin/sh -c #(nop)  EXPOSE 3000                  0B                  
27584ac9ce09        About a minute ago   /bin/sh -c #(nop) COPY --chown=node:nodedir:…   1.76MB              
616aa5684300        19 minutes ago       /bin/sh -c #(nop) COPY --chown=node:nodedir:…   24.5kB              
68d0bd922182        19 minutes ago       /bin/sh -c #(nop)  USER node                    0B                  
ef2c6f80523b        19 minutes ago       /bin/sh -c #(nop) WORKDIR /home/node/app        0B                  
b440673b3fe0        19 minutes ago       |1 APP_HOME=/home/node/app /bin/sh -c mkdir …   0B                  
fe456e11f465        19 minutes ago       /bin/sh -c #(nop)  ARG APP_HOME=/home/node/a…   0B                  
14e538b8a88f        19 minutes ago       /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
51d926a5599d        2 weeks ago          /bin/sh -c #(nop)  CMD ["node"]                 0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop) COPY file:238737301d473041…   116B                
<missing>           2 weeks ago          /bin/sh -c apk add --no-cache --virtual .bui…   7.62MB              
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.5      0B                  
<missing>           2 weeks ago          /bin/sh -c addgroup -g 1000 node     && addu…   103MB               
<missing>           2 weeks ago          /bin/sh -c #(nop)  ENV NODE_VERSION=14.15.3     0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           2 weeks ago          /bin/sh -c #(nop) ADD file:8ed80010e443da19d…   5.61MB              
```

There's only 1.8MB contribution from our own app, thus we cannot anymore
optimize the size anymore without changing the base image. `node:14-alpine`
takes 116MB of space.

We could change base image to pure alpine to get even smaller image. It seems
that `node:14-alpine` is installing some extra stuff, like npm, which is not
strictly needed when starting the app.

Fixes:

- **e047318** Use alpine as base image instead of node:14-alpine (118MB -> 42MB)

Are we done? By creating alpine image and `apk add --update nodejs`, we can see
that apk is adding also other stuff, like ssl certificates.

After installing node, we can observe it's dynamically linked:

```text
/ # ldd /usr/bin/node
    /lib/ld-musl-x86_64.so.1 (0x7fb6e8824000)
    libz.so.1 => /lib/libz.so.1 (0x7fb6e6ad4000)
    libuv.so.1 => /usr/lib/libuv.so.1 (0x7fb6e6aaa000)
    libbrotlidec.so.1 => /usr/lib/libbrotlidec.so.1 (0x7fb6e6a9e000)
    libbrotlienc.so.1 => /usr/lib/libbrotlienc.so.1 (0x7fb6e6a1a000)
    libcares.so.2 => /usr/lib/libcares.so.2 (0x7fb6e6a07000)
    libnghttp2.so.14 => /usr/lib/libnghttp2.so.14 (0x7fb6e69e2000)
    libcrypto.so.1.1 => /lib/libcrypto.so.1.1 (0x7fb6e6762000)
    libssl.so.1.1 => /lib/libssl.so.1.1 (0x7fb6e66e1000)
    libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0x7fb6e6548000)
    libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0x7fb6e6534000)
    libc.musl-x86_64.so.1 => /lib/ld-musl-x86_64.so.1 (0x7fb6e8824000)
    libbrotlicommon.so.1 => /usr/lib/libbrotlicommon.so.1 (0x7fb6e6511000)
```

Installing nodejs is adding 34.6MB to image in addition to the 5.58MB base image.

Copying the files to the scratch:

```Dockerfile
FROM alpine AS node
RUN apk add nodejs=12.18.4-r0

FROM scratch AS node-scratch
COPY --from=node /usr/bin/node /usr/bin/node
COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /lib/libz.so.1 /lib/libz.so.1
COPY --from=node /lib/libz.so.1.2.11 /lib/libz.so.1.2.11
COPY --from=node /usr/lib/libuv.so.1 /usr/lib/libuv.so.1
COPY --from=node /usr/lib/libuv.so.1.0.0 /usr/lib/libuv.so.1.0.0
COPY --from=node /usr/lib/libbrotlidec.so.1 /usr/lib/libbrotlidec.so.1
COPY --from=node /usr/lib/libbrotlidec.so.1.0.9 /usr/lib/libbrotlidec.so.1.0.9
COPY --from=node /usr/lib/libbrotlienc.so.1 /usr/lib/libbrotlienc.so.1
COPY --from=node /usr/lib/libbrotlienc.so.1.0.9 /usr/lib/libbrotlienc.so.1.0.9
COPY --from=node /usr/lib/libcares.so.2 /usr/lib/libcares.so.2
COPY --from=node /usr/lib/libcares.so.2.4.0 /usr/lib/libcares.so.2.4.0
COPY --from=node /usr/lib/libnghttp2.so.14 /usr/lib/libnghttp2.so.14
COPY --from=node /usr/lib/libnghttp2.so.14.20.0 /usr/lib/libnghttp2.so.14.20.0
COPY --from=node /lib/libcrypto.so.1.1 /lib/libcrypto.so.1.1
COPY --from=node /lib/libssl.so.1.1 /lib/libssl.so.1.1
COPY --from=node /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=node /usr/lib/libstdc++.so.6.0.28 /usr/lib/libstdc++.so.6.0.28
COPY --from=node /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /usr/lib/libbrotlicommon.so.1 /usr/lib/libbrotlicommon.so.1
COPY --from=node /usr/lib/libbrotlicommon.so.1.0.9 /usr/lib/libbrotlicommon.so.1.0.9

CMD ["/usr/bin/node"]
```

This results 39.6MB images. Too much layers. Maybe one more trick is to create
another scratch where performing `RUN copy --from=image / /`.

Before merging, the size of different partions of image are:

```text
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
43fee56cb59e        7 seconds ago       /bin/sh -c #(nop)  CMD ["/usr/bin/node" "/ap…   0B                  
1b1caa367c59        7 seconds ago       /bin/sh -c #(nop)  EXPOSE 3000                  0B                  
23851729d8c4        15 minutes ago      /bin/sh -c #(nop) COPY dir:9e9a7b6de054ec500…   1.79MB              
0151ddd1dc11        31 minutes ago      /bin/sh -c #(nop) COPY dir:64bd8c157c32fe540…   24.5kB              
66cb107388f0        31 minutes ago      /bin/sh -c #(nop) COPY dir:07dff61d25f4558ac…   39MB                
0361c58da3ca        31 minutes ago      /bin/sh -c #(nop) WORKDIR /app                  0B                  
df4799b43c4e        31 minutes ago      /bin/sh -c #(nop)  ARG APP_HOME=/app            0B                  
```

Combining everything into a single layer, the size of the final product is 40.8MB.

```text
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
524feec77976        21 seconds ago      /bin/sh -c #(nop)  CMD ["/usr/bin/node" "/ap…   0B                  
b7960ab4bccb        21 seconds ago      /bin/sh -c #(nop)  EXPOSE 3000                  0B                  
e34c1b425fcb        21 seconds ago      /bin/sh -c #(nop) COPY dir:04d355a8e8aab9d31…   40.8MB              
```

The detailed input of the docker image contents is given in `docker_content.lst`.

Fixes:

- **f17c8e9** Use scratch image (42MB -> 40.8MB)

The final `Dockerfile` is

```Dockerfile
FROM node:14-alpine AS app

WORKDIR /wrk

# Build package
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Build ready, let's remove node_modules and install production dependencies
RUN rm -rf node_modules
ENV NODE_ENV=production
RUN npm install --production


### Time to create nodejs scratch ###
FROM alpine AS node
RUN apk add nodejs=12.18.4-r0


### Copy only relevant files from node ###
FROM scratch AS node-scratch
COPY --from=node /usr/bin/node /usr/bin/node
COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /lib/libz.so.1 /lib/libz.so.1
COPY --from=node /lib/libz.so.1.2.11 /lib/libz.so.1.2.11
COPY --from=node /usr/lib/libuv.so.1 /usr/lib/libuv.so.1
COPY --from=node /usr/lib/libuv.so.1.0.0 /usr/lib/libuv.so.1.0.0
COPY --from=node /usr/lib/libbrotlidec.so.1 /usr/lib/libbrotlidec.so.1
COPY --from=node /usr/lib/libbrotlidec.so.1.0.9 /usr/lib/libbrotlidec.so.1.0.9
COPY --from=node /usr/lib/libbrotlienc.so.1 /usr/lib/libbrotlienc.so.1
COPY --from=node /usr/lib/libbrotlienc.so.1.0.9 /usr/lib/libbrotlienc.so.1.0.9
COPY --from=node /usr/lib/libcares.so.2 /usr/lib/libcares.so.2
COPY --from=node /usr/lib/libcares.so.2.4.0 /usr/lib/libcares.so.2.4.0
COPY --from=node /usr/lib/libnghttp2.so.14 /usr/lib/libnghttp2.so.14
COPY --from=node /usr/lib/libnghttp2.so.14.20.0 /usr/lib/libnghttp2.so.14.20.0
COPY --from=node /lib/libcrypto.so.1.1 /lib/libcrypto.so.1.1
COPY --from=node /lib/libssl.so.1.1 /lib/libssl.so.1.1
COPY --from=node /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=node /usr/lib/libstdc++.so.6.0.28 /usr/lib/libstdc++.so.6.0.28
COPY --from=node /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
COPY --from=node /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=node /usr/lib/libbrotlicommon.so.1 /usr/lib/libbrotlicommon.so.1
COPY --from=node /usr/lib/libbrotlicommon.so.1.0.9 /usr/lib/libbrotlicommon.so.1.0.9

### Build final image ###
FROM scratch AS final
ARG APP_HOME=/app
WORKDIR ${APP_HOME}
# Copy node (change node-scratch to node to get full alpine image)
COPY --from=node-scratch / /
# Copy app
COPY --from=app /wrk/build ${APP_HOME}
# Copy app dependencies
COPY --from=app /wrk/node_modules ${APP_HOME}/node_modules

### Merge node, app and app dependencies into a single layer
FROM scratch
COPY --from=final / /
EXPOSE 3000
CMD ["/usr/bin/node", "/app/src/index.js"]
```

## Final remark

Alpine+Node image was already 42MB and the smallest possible image size is
40.8MB, so there is no much point of going further optimizations by copying node
to scratch image from alpine, from the point of view about the size of the
image. However, the latter image might be more secure as there is somewhat less
attach surface. There is absolutely nothing else than node executable and source
code.

At the beginning image size was 397MB and it was already build on top of
`node:12-alpine`, so it was a bit suprising that so much of size still could be
optimized.

[1]: https://github.com/ahojukka5/patientor-backend
