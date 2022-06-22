#!/bin/bash
REPO=https://github.com/ACDI-Argentina/give-4-forest-feathers.git
BRANCH=master
TARGET_DIR=./feathers/app

rm -rf ${TARGET_DIR}
git clone --branch ${BRANCH} ${REPO} ${TARGET_DIR}


