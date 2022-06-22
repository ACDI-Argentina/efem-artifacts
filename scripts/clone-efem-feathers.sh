#!/bin/bash
REPO=https://github.com/ACDI-Argentina/efem-users-feathers.git
BRANCH=master
TARGET_DIR=./efem-users-feathers/app

rm -rf ${TARGET_DIR}
git clone --branch ${BRANCH} ${REPO} ${TARGET_DIR}

