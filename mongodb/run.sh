#!/bin/bash

docker run -d \
           -p 27017:27017 \
           --network efem-network \
           -v /home/jduttweiler/docker-volumes/mongo:/data/db\
           --name mongo-db\
            mongo:3.6.18
