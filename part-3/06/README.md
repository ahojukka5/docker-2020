# Exercise 3.6

Original image sizes:

```text
18:37 $ docker-compose images
  Container     Repository     Tag       Image Id       Size  
--------------------------------------------------------------
05_backend_1    05_backend    latest   523a96ab9462   131.5 MB
05_frontend_1   05_frontend   latest   81ededdb7992   365.4 MB
```

Let's do multi-stage build for frontend and host it using nginx.

New image using base image `nginx:1.19.6-alpine`:

```text
18:50 $ docker history ahojukka5/frontend-example-docker:latest 
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
19aa059c5f8d        12 seconds ago      /bin/sh -c #(nop) COPY dir:0e26e1dc528123cfe…   2.74MB              
41250581d0e2        12 seconds ago      /bin/sh -c #(nop)  EXPOSE 80                    0B                  
629df02b47c8        2 weeks ago         /bin/sh -c #(nop)  CMD ["nginx" "-g" "daemon…   0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  STOPSIGNAL SIGQUIT           0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  EXPOSE 80                    0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENTRYPOINT ["/docker-entr…   0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:0fd5fca330dcd6a7…   1.04kB              
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:0b866ff3fc1ef5b0…   1.96kB              
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:e7e183879c35719c…   1.2kB               
<missing>           2 weeks ago         /bin/sh -c set -x     && addgroup -g 101 -S …   16.8MB              
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV PKG_RELEASE=1            0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV NJS_VERSION=0.5.0        0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV NGINX_VERSION=1.19.6     0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  LABEL maintainer=NGINX Do…   0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
<missing>           2 weeks ago         /bin/sh -c #(nop) ADD file:ec475c2abb2d46435…   5.58MB              
```

New image sizes:

```text
18:57 $ docker-compose images
  Container     Repository     Tag       Image Id       Size  
--------------------------------------------------------------
06_backend_1    06_backend    latest   523a96ab9462   131.5 MB
06_frontend_1   06_frontend   latest   19aa059c5f8d   25.08 MB
```

From 365.4 MB to 25.08 MB.
