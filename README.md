# <img src='app/assets/images/studiovinari-brands.svg?raw=true' width="50" height="50"/> Shorten Url Project

Hello,

Thank you for checking out my assignment. You can have a quick video demo as follow:

## Demo video

Note: You should play at 1.5x speed

[Demo 1](https://www.loom.com/share/6807c890ae6642158c695c0a93e235ff)
[Demo 2](https://www.loom.com/share/682a3a5c92de4f368f3ad0e115bb40e3)
[Demo 3](https://www.loom.com/share/227a4f63e68a4a5ebf3920a17d60bdb4)

## Visit project on production:

https://blooming-badlands-76554.herokuapp.com/

## Clone project:

```
$ git clone git@github.com:thanhtruong1216/shorten-url-be.git
```

or

```
$ git clone https://github.com/thanhtruong1216/shorten-url-be.git
```

## Run project

```
$ bundle
$ rails s
```

## Base url

### front_end_base_url

- On local: "http://localhost:3000"
- On production: "https://blooming-badlands-76554.herokuapp.com"

## Use application

- Go to ${front_end_base_url}/sign_up to create new account
- Go to ${front_end_base_url}/sign_in to log in
- Go to ${front_end_base_url}/links to create new link and see your links

# SpiderBox Design Ruby on Rails Assessment

## 1. THE URL SHORTENER CHALLENGE

Your mission is to make a URL shortener full-stack application using any database engine, Ruby On Rails, (bonus points if the frontend is a SPA in ReactJS).
Create one repo if you work entirely with RoR, or two repos if you work with Rails + React. Send us the links of both repositories.

+kudos If you use docker, that would be great and give extra points.

### CORE REQUIREMENTS

- [x] As a visitor, I want to create an account for the app, so that I become an active user.

  Acceptance Criteria:

      - [x] Application needs my name, email, and password.
      - [x] Duplicated emails are not allowed.
      - [x] Validates email input.

- [x] As an active user I must be able to put a URL into the home page and get back a URL of the shortest possible length.

      AC:
        - [x] You shouldn't use any gem or library that provides the short url algorithm
        - [x] Inputting a valid URL should result in displaying the new shortened URL to the user.
        - [x] Inputting an invalid URL should result in displaying errors to the user.

- [x] As an active user I must be able to manage my links, edit, create, destroy.

- [x] As an active user, every time I share this link, I must be redirected to the full URL when we enter the short URL (ex: [http://app.com/aSdF](http://app.com/aSdF)​ =>​ [​https://google.com​](​https://google.com​)).
- [x] As an active user I want to see a list of my links, ordered by creation date.
- [x] As an active user I want to click on my links to see details and stats.

      AC:
        - [x] I want to see how many times my link was clicked.

- [x] There must be a README that explains how to set up the application and the algorithm used for generating the URL shortcode.

- [x] As an active user I want an API key to access and integrate any other platform with this shortener.

      AC:
        - [x] I want an endpoint to access all my links.
        - [x] All endpoint results must be paginated.
        - [x] I want an endpoint to shorten new URLs.

API doc:

### List Links

```bash
export APIKEY='67348f4a3d0479dd6cf6e8eb1e519657'
export HOST='https://shortenurlbe.herokuapp.com'

curl --request GET "$HOST/links" \
     --header "Authorization: Token $APIKEY" | jq .
```

### With pagination

```bash
curl --request GET "$HOST/links?page=2&page_size=2" \
     --header "Authorization: Token $APIKEY" | jq .
```

### Create new Link

```bash
curl  --request POST "$HOST/links" \
      --header "Authorization: Token $APIKEY" \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "link": {
            "title": "link new 3",
            "url": "https://www.youtube.com/watch?v=HZi4eJXWZU0"
          }
      }' | jq .
```

[x] Bonus point if you test all your code with RSpec.

### Project convention

#### The type of commit messages

- feat: a new feature
- fix: a bug fix
- docs: changes to documentation
- style: formatting, missing semi colons, etc; no code change
- refactor: refactoring production code
- test: adding tests, refactoring test; no production code change
- chore: updating build tasks, package manager configs, etc; no production code change
