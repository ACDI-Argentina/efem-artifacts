#!/bin/bash
IMAGE=efem/feathers
CONTAINER=efem-feathers

docker run -d \
           -p 3030:3030 \
           --network efem-network\
           --name ${CONTAINER}\
           ${IMAGE}
