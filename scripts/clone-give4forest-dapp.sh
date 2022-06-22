#!/bin/bash
REPO=https://github.com/ACDI-Argentina/give-4-forest.git
BRANCH=master
TARGET_DIR=./dapp/app

rm -rf ${TARGET_DIR}
git clone --branch ${BRANCH} ${REPO} ${TARGET_DIR}

