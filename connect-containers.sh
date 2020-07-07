#!/bin/bash

NETWORK=efem-network

#docker network create ${NETWORK}

docker network connect ${NETWORK} efem-dapp
docker network connect ${NETWORK} efem-feathers
docker network connect ${NETWORK} mongo-db
docker network connect ${NETWORK} efem-rsk
docker network connect ${NETWORK} efem-ipfs


