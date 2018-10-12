# docker example 

This is a template for docker image and its deplyment(using docker compose) for armv6 and x86. 
- Dockerfile template for image.
- Docker compose file template for deployment.
- gitbook template for github page.
- travis file template for CI.

You can use this project to quick start your docker image project. 

By using travis CI, Work flow works like below:
- Push code to remote branch develop or master :
    - Build image
    - Push the image to docker hub and tag it with branch name
- Push a tag to remote
    - Build image
    - Push the image to docker hub and tag it with the git tag
    - Build the deployment
    - Publish the tag to a prerelease and push the deployment to this prerelease

# How to use

### Download the template from release.
- Go to the release page ([here](https://github.com/ChineseTeapot/docker-example/releases))
- Select the latest release and click to download.

### Unzip and check the md5
```bash
$ unzip docker-example-[version].zip
$ cd docker-example/
$ md5sum -c docker-example-[version].md5
```

### Config for new project
- rename the directory.
    ```bash
    $ mv docker-example [project]
    $ cd [project]/
    $ rm docker-example-[version].md5
    ```

- init git 
    ```bash
    $ cd [project]/
    $ git init
    $ git add -A
    $ git commit -m "add docker image template"
    $ git remote add origin https://github.com/OWNER/REPO.git
    $ git push -u origin master
    ```
    Replace the key words `OWNER` and `REPO` with your github user and project.

- specify the repo
    ```bash
    $ vim Makefile
    ```
    Modify the value of variables `OWNER` and `REPO` to your github user and project.

- specify the account info

  gihub account and dockerhub account

### Write the image dockerfile

### Write the image deployment

