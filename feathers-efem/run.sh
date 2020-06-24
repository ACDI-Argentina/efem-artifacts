#!/bin/bash
IMAGE=efem/feathers
CONTAINER=efem-feathers
CONFIG_PATH=$(pwd)/config/default.json
APP_PATH=/usr/src/app

docker run -d \
           -p 3030:3030 \
           --network efem-network\
           --name ${CONTAINER}\
           -v ${CONFIG_PATH}:${APP_PATH}/config/default.json\
           ${IMAGE}

docker logs -f ${CONTAINER}