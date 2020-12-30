# Exercise 1.15

My earlier project [patientor-backend][1] is available in [docker][2]. It can be
launched with the following command:

```bash
docker run --rm -it --name patientor-backend -p 3000:3000 ahojukka5/patientor-backend
```

If everything is working, running `curl localhost:3000/api/ping` should return
message "ping pong".

[1]: https://github.com/ahojukka5/patientor-backend
[2]: https://hub.docker.com/r/ahojukka5/patientor-backend
