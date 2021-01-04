# Exercise 3.3

Created. As a result, a new package gontti is introduced. It's living in Github <https://github.com/ahojukka5/Gontti>. It can be used inside Docker container:

```bash
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_XRA=xxyyzz ahojukka5/gontti <name>
```

Here, repo is name of image and at the same time the repository in Docker
registry, like `ahojukka5/gontti`.

As a test, gontti is used to deploy itself to Docker hub when push to the repository is made, see [here][1].

[1]: https://github.com/ahojukka5/Gontti/blob/master/.github/workflows/deploy.yml
