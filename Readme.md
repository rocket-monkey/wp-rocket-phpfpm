# wp-rocket-phpfpm

a pure Docker container project, containing only of a "Dockerfile" describing our special php-fpm container.
It will let run php as a fastcgi module, usable as an upstream application by nginx - and it has only one single purpose, processing php scripts.

## How to publish to AWS ECS (Elastic Container Service)

> goto: https://eu-central-1.console.aws.amazon.com/ecs/home?region=eu-central-1#/repositories/rm-wp-rocket-phpfpm#images;tagStatus=ALL

> followed by the docs here: https://circleci.com/blog/circleci-aws-ecrecs/ and https://github.com/circleci/circle-ecs

1) Retrieve the docker login command that you can use to authenticate your Docker client to your registry:
```
aws ecr get-login --region eu-central-1
```

2) Run the docker login command that was returned in the previous step.
3) Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions [here](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html). You can skip this step if your image is already built:
```
docker build -t rm-wp-rocket-phpfpm .
```

4) After the build completes, tag your image so you can push the image to this repository:
```
docker tag rm-wp-rocket-phpfpm:latest 723902011217.dkr.ecr.eu-central-1.amazonaws.com/rm-wp-rocket-phpfpm:latest
```

5) Run the following command to push this image to your newly created AWS repository:
```
docker push 723902011217.dkr.ecr.eu-central-1.amazonaws.com/rm-wp-rocket-phpfpm:latest
```

## How to publish to Docker Hub

> followed by the docs here: https://docs.docker.com/engine/tutorials/dockerimages/

1) Login with docker to your dockerhub.com account
```
docker login
```

2) Build the image from your Dockerfile in your project folder and give it an explicit name (<scope>/<package-name>:<version>)
```
docker run -t -i rocketmonkey/wp-rocket-phpfpm:latest /bin/bash

root@8196968dac35:/#
```

> above command will bring you into the bash of the freshly built container -> we need this to see the actual id on the prompt of the new image (the hash after "root@", ending right before the ":")

3) Tag the image now
```
docker tag 8196968dac35 rocketmonkey/wp-rocket-phpfpm:latest
```

4) And finally push it to docker hub
```
docker push rocketmonkey/wp-rocket-phpfpm
```
