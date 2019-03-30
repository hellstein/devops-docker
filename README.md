# Introduction 

This is a devops for docker image and its deployment (using docker compose) for armv6 and x86. It contains:
- Dockerfile template for image.
- Docker compose file template for deployment.
- gitbook template for github page.
- travis file template for CI.

You can use this project to quick start your docker image project with the following outcome,

* It sets up local build process
* It sets up travis build process


# Usage 

### Go to your project
```
cd myproj
```

### Get the [release](https://github.com/hellstein/devops-gitbook/releases)
```
wget https://github.com/hellstein/devops-docker/releases/download/0.2.2/proj-0.2.2.zip
```

### Unzip
```
unzip proj-0.2.2.zip
```
You will see the `proj` folder.

### Set project
```
mv proj/* proj/.[!.]* ./
rm -rf proj*
```

### Set the `OWNER` and `REPO` with your github user and project
```bash
./set_owner_repo [OWNER] [REPO]
```

### Specify develop local build usage

Till now, you can validate by

* Local build process
  - Create docker image by `make mk-image ARCH=x86` or `make mk-image ARCH=armv6`. Test result with `docker images`.

  - Create gitbook by `make mk-book`, a docs folder will be generated
  - Create deployment by `make mk-deployment VERSION=0.1.0`, 2 zip packages will be generated according to your repository name and version.

* Local clean process
  - Delete docker image by `make clean-image ARCH=x86` or `make clean-image ARCH=armv6`
  - Delete gitbook result by `make clean-book`
  - Delete deployment result by `make clean-deployment VERSION=0.1.0`

### Write the image dockerfile and the image deployment
- Modify `images/Dockerfile-armv6(x86)` which defines how to build images
- Go to `deployment/imageAPI-armv6 (x86)`
  * Update `docker-compose.yml` which defines how to run images
  * Update `temp.env` which defines environment variable used by `docker-compose.yml`

### Valid dockerfile and image deployment as before 

### Travis build

- specify the docker hub account info
  * `travis login`
  * `travis enable`
  * Change `.env` by setting `DOCKER_USER` and `DOCKER_PASS`
  * `./set_docker_account`

- Set github release api key

  Go to [github and get a token](https://github.com/settings/tokens).
```bash
./set_release_api_key [token]
```
- Modify the indentation like below:
```yaml
deploy:
- provider: script
  script: make pushtohub USER=$DOCKER_USER PASS=$DOCKER_PASS ARCH=$ARCH TAG=$TRAVIS_BRANCH
  on:
    all_branches: true
    condition: "$TRAVIS_BRANCH =~ ^master|develop$"
- provider: script
  script: make pushtohub USER=$DOCKER_USER PASS=$DOCKER_PASS ARCH=$ARCH TAG=$TRAVIS_TAG
  on:
    tags: true
    all_branches: true
- provider: releases
  prerelease: true
  skip_cleanup: true
  file_glob: true
  file: "./*.zip"
  api_key:
    secure: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  on:
    tags: true
```
- Test whether .travis.yml is ok
```bash
travis lint .travis.yml
```

- Now you can push a branch or tag to check whether travis does its job as expected


