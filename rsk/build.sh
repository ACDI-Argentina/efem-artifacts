#!/bin/bash

cd ./build
docker build . -t regtest -f Dockerfile.RegTest