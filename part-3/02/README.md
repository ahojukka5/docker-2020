# Exercise 3.2

App `ahojukka5/express-hello-world` is online at <https://ahojukka5-express-hello-world.herokuapp.com/>.

GitHub repo: <https://github.com/ahojukka5/express-hello-world>.

GitHub Action to deploy to Heroku:

```yml
name: Deploy to Heroku as container

on:
  push:
    branches: master

jobs:
  main:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Build, Push and Deploy to Heroku
        id: heroku
        uses: jctaveras/heroku-deploy@v2.1.1
        with:
          email: ${{ secrets.HEROKU_EMAIL }}
          api_key: ${{ secrets.HEROKU_API_KEY }}
          app_name: ahojukka5-express-hello-world
```
