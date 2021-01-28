#!/bin/bash
cd /home/jona/blockchain/efem
docker rm efem-rsk
docker-compose -f docker-compose.development.yml up efem-rsk
