# Exercise 1.4

## Commands:

Start container:

```bash
docker run --rm --name=exec_bash_exercise devopsdockeruh/exec_bash_exercise
```

Read logs:

```bash
docker exec -it exec_bash_exercise /usr/bin/tail -f ./logs.txt
```

Secret message is "Docker is easy".
