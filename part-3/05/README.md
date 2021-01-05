# Exercise 3.5

Original image sizes:

```text
  Container     Repository     Tag       Image Id       Size  
--------------------------------------------------------------
04_backend_1    04_backend    latest   50e8b46fed1e   605.9 MB
04_frontend_1   04_frontend   latest   ce87f1608a3b   1.027 GB
```

After changing images to `node:14-alpine`:

```text
18:24 $ docker history ahojukka5/backend-example-docker:latest 
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
523a96ab9462        4 minutes ago       /bin/sh -c #(nop)  CMD ["npm" "start"]          0B                  
79cb60df663f        4 minutes ago       /bin/sh -c #(nop)  EXPOSE 8000                  0B                  
f2ae070a2a46        4 minutes ago       /bin/sh -c npm install --production             15.3MB              
c62fb6ec8149        6 minutes ago       /bin/sh -c #(nop) WORKDIR /home/node/app        0B                  
f0810ba639f6        6 minutes ago       /bin/sh -c mv backend-example-docker-master …   73.2kB              
77f93a7c1fc3        6 minutes ago       /bin/sh -c wget https://github.com/docker-hy…   73.2kB              
c2b8a8fae4a4        6 minutes ago       /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B                  
07754b9a157b        6 minutes ago       /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
6d6981f0c232        6 minutes ago       /bin/sh -c #(nop) WORKDIR /home/node            0B                  
a0c4e51060de        8 minutes ago       /bin/sh -c #(nop)  USER node                    0B                  
51d926a5599d        2 weeks ago         /bin/sh -c #(nop)  CMD ["node"]                 0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:238737301d473041…   116B                
<missing>           2 weeks ago         /bin/sh -c apk add --no-cache --virtual .bui…   7.62MB              
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.5      0B                  
<missing>           2 weeks ago         /bin/sh -c addgroup -g 1000 node     && addu…   103MB               
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV NODE_VERSION=14.15.3     0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) ADD file:8ed80010e443da19d…   5.61MB              
```

```text
18:36 $ docker history ahojukka5/frontend-example-docker:latest 
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
81ededdb7992        2 seconds ago       /bin/sh -c #(nop)  CMD ["-n" "-s" "-l" "5000…   0B                  
a3d5668eb302        2 seconds ago       /bin/sh -c #(nop)  ENTRYPOINT ["/home/node/.…   0B                  
51cf4bea7dcb        2 seconds ago       /bin/sh -c #(nop)  EXPOSE 5000                  0B                  
de27515feefb        3 seconds ago       /bin/sh -c npm install -g serve                 5.63MB              
42240880e4b0        9 seconds ago       /bin/sh -c #(nop)  ENV NPM_CONFIG_PREFIX=/ho…   0B                  
10e92e60d368        9 seconds ago       /bin/sh -c npm run build                        30.7MB              
1dc45ddc5c9a        11 minutes ago      /bin/sh -c npm install --production             212MB               
69e1d17eeafe        12 minutes ago      /bin/sh -c #(nop) WORKDIR /home/node/app        0B                  
9937e26252e6        12 minutes ago      /bin/sh -c mv frontend-example-docker-master…   557kB               
4b1b914ea93e        12 minutes ago      /bin/sh -c wget https://github.com/docker-hy…   557kB               
e9ab46960ba0        12 minutes ago      /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B                  
07754b9a157b        17 minutes ago      /bin/sh -c #(nop)  ENV NODE_ENV=production      0B                  
6d6981f0c232        17 minutes ago      /bin/sh -c #(nop) WORKDIR /home/node            0B                  
a0c4e51060de        18 minutes ago      /bin/sh -c #(nop)  USER node                    0B                  
51d926a5599d        2 weeks ago         /bin/sh -c #(nop)  CMD ["node"]                 0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:238737301d473041…   116B                
<missing>           2 weeks ago         /bin/sh -c apk add --no-cache --virtual .bui…   7.62MB              
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.22.5      0B                  
<missing>           2 weeks ago         /bin/sh -c addgroup -g 1000 node     && addu…   103MB               
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV NODE_VERSION=14.15.3     0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) ADD file:8ed80010e443da19d…   5.61MB              
```

Sizes after changing base image:

```text
18:37 $ docker-compose images
  Container     Repository     Tag       Image Id       Size  
--------------------------------------------------------------
05_backend_1    05_backend    latest   523a96ab9462   131.5 MB
05_frontend_1   05_frontend   latest   81ededdb7992   365.4 MB
```

Backend from 605.9 MB to 131.5 MB
Frontend from 1.027 GB to 365.4 MB
