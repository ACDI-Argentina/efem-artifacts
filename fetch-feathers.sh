#!/bin/bash
REPO=https://github.com/ACDI-Argentina/efem-crowdfunding-feathers.git
BRANCH=efem-dev
TARGET_DIR=./feathers/app

rm -rf ${TARGET_DIR}
git clone --branch ${BRANCH} ${REPO} ${TARGET_DIR}


