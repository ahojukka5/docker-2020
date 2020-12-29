# Exercise 1.9

Used commands:

```bash
docker pull devopsdockeruh/ports_exercise

docker run -d -it --name=ports_exercise -p 80:80 devopsdockeruh/ports_exercise

sleep 1

curl localhost:80

docker rm --force ports_exercise
```
