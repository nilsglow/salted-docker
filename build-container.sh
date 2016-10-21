#!/bin/bash

NAME=localhost:5000/nilsglow/salted-docker
TAG=latest

docker build -t $NAME:$TAG .
docker push $NAME:$TAG
container_id=$(docker create -v $1:/srv/salt $NAME:$TAG)
docker start $container_id
docker exec $container_id salt-call --local state.apply
docker commit $container_id $NAME:$TAG
docker push $NAME:$TAG
