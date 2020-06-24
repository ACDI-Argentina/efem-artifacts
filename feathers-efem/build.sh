#!/bin/bash
REPO=https://github.com/ACDI-Argentina/efem-crowdfunding-feathers.git
BRANCH=efem-dev
DIR=app
IMAGE_NAME=efem/feathers

git clone --branch ${BRANCH} ${REPO} ${DIR}

docker build . -t ${IMAGE_NAME}

