#!/bin/bash
IMAGE=efem/dapp
CONTAINER=efem-dapp

APP_PATH=/usr/src/app
CONFIG_PATH=$(pwd)/config/configuration.js

#Agregar variables de entorno definidas en https://github.com/ACDI-Argentina/efem-crowdfunding-dapp/tree/efem-dev#run
docker run -d --rm \
       -p 3010:3010 \
       --network efem-network\
       --name ${CONTAINER} \
       -v ${CONFIG_PATH}:${APP_PATH}/src/configuration.js \
       ${IMAGE}


docker logs -f  ${CONTAINER}