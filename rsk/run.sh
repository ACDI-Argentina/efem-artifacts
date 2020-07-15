#!/bin/bash

CONTAINER_NAME="efem-rsk"
IMAGE_NAME="efem/rsk-regtest"

docker run -d \
           --name ${CONTAINER_NAME} \
           -p 4444:4444 \
           -p 4445:4445\
           -p 30305:30305 \
           --network efem-network \
           ${IMAGE_NAME}
