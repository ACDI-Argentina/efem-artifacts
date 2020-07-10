#!/bin/bash
REPO=https://github.com/ACDI-Argentina/efem-crowdfunding-dapp.git
BRANCH=efem-dev
TARGET_DIR=./dapp/app

rm -rf ${TARGET_DIR}
git clone --branch ${BRANCH} ${REPO} ${TARGET_DIR}

