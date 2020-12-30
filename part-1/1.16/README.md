# Exercise 1.16

Workflow:

Pull image

```bash
docker pull devopsdockeruh/heroku-example
```

In Heroku, create new app, give it name ahojukka5-heroku-example

Tag image:

```bash
docker tag devopsdockeruh/heroku-example registry.heroku.com/ahojukka5-heroku-example/web
```

With `docker images` new image with new tag should be found.

Run `heroku login` and `heroku container:login`.

Push image to Heroku:

```bash
docker push registry.heroku.com/ahojukka5-heroku-example/web
```

Release image:

```bash
heroku container:release web -a ahojukka5-heroku-example
```

Something is online at <https://ahojukka5-heroku-example.herokuapp.com/> !
