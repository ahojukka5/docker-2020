# Exercise 1.8

To mount file, it is important that file already exists on host machine, thus

```bash
touch logs.txt
```

After that, run docker container with mount:

```bash
docker run --rm -it \
    --name=first_volume_exercise \
    -v "${PWD}/logs.txt:/usr/app/logs.txt" \
    devopsdockeruh/first_volume_exercise
```
