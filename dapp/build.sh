#!/bin/bash
REPO=https://github.com/ACDI-Argentina/efem-crowdfunding-dapp.git
BRANCH=efem-dev
DIR=app
IMAGE_NAME=efem/dapp

git clone --branch ${BRANCH} ${REPO} ${DIR}

docker build . -t ${IMAGE_NAME}
