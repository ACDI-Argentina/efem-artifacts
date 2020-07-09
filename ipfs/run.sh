#!/bin/bash
IMAGE_NAME=efem/ipfs
CONTAINER_NAME=efem-ipfs
ipfs_staging=/home/jduttweiler/docker-volumes/ipfs
ipfs_data=/home/jduttweiler/docker-volumes/ipfs/data

docker run -d \
           --name ipfs_host \
           -v $ipfs_staging:/export \
           -v $ipfs_data:/data/ipfs \
           -p 4001:4001 \
           -p 8080:8080 \
           -p 5001:5001 \
           --name ${CONTAINER_NAME}\
           --network efem-network\
           ${IMAGE_NAME}

