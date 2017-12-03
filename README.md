# bitbucket2gitlab

This is a small rake task to migrate all bitbucket projects and repositories 
into gitlab via REST-API. Each bitbucket project will be a group namespace in gitlab. 

Migrated a self hosted bitbucket server to a docker based gitlab on an synology nas.

## pre conditions

You need some work to do ;-)

### bitbucket

You just need your username, password and the base url of your api, e.g. https://bitbucket.example.com/rest/api/1.0

### gitlab

Create an access token for the user who can create and import, you can find it under your 
profile settings -> access token tab. 
And of course, the gitlab api base url, e.g. https://gitlab.example.com/api/v4

## setup

```
# clone this repo
git clone https://github.com/Loumaris/bitbucket2gitlab.git
cd bitbucket2gitlab

# install dependencies
bundle install

# edit .env and add your data for bitbucket and gitlab
vi .env

# start migration
rake
```

Done :)


## Todo

Currently there is no way to migrate the project avatars to gitlab via API.