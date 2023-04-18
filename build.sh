#!/bin/bash
# Exit script in case of error
set -e

docker-compose build --no-cache
docker-compose push