# Exercise 2.10

Make buttons work in nginx proxy. To run, type:

```bash
docker-compose up --build
```

Changes:

- In frontend/Dockerfile, change `FRONT_URL` to `http://localhost`, i.e. use proxy.
- In backend/Dockerfile, change `API_URL` to `http://localhost/api`, i.e. use proxy.
