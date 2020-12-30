# Exercise 1.5

Create separate script file `script.sh`:

```sh
#!/bin/bash

apt-get update && apt-get install -y curl

echo "Input website:"
read website
echo "Searching.."
sleep 1
curl http://$website
```

Run with docker:

```bash
docker run --rm -it --name=ex1.4 -v ${PWD}:/app ubuntu:16.04 /app/script.sh
```

To fix the problem, add `-L` flag to the curl command, i.e. replace the last
line of `script.sh` with:

```sh
curl -L http://$website
```

This makes curl follow redirects.
