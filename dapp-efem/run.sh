#!/bin/bash
IMAGE=efem/dapp
CONTAINER=efem-dapp

#Agregar variables de entorno definidas en https://github.com/ACDI-Argentina/efem-crowdfunding-dapp/tree/efem-dev#run
docker run -d --rm \
       -p 3010:3010 \
       --network efem-network\
       --name ${CONTAINER} \
       ${IMAGE}
