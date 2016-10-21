#!/bin/bash

NAME=localhost:5000/nilsglow/salted-docker
TAG=latest

docker build -t $NAME:$TAG .
docker push $NAME:$TAG
container_id=$(docker create -v $(pwd)/salt/states:/srv/salt $NAME:$TAG salt-call --local state.apply)
docker start -a $container_id
docker commit $container_id $NAME:$TAG
docker push $NAME:$TAG
