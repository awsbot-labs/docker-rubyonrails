#!/bin/bash
boot2docker up
# Download docker-compose
curl -L https://github.com/docker/compose/releases/download/1.3.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Run the docker-compose project
docker-compose up -d
# Check the docker processes are running
docker ps
sleep 43
# Connect to the hellorails app
curl http://$(boot2docker ip)
