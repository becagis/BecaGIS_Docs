#!/bin/bash

# Exit script in case of error
set -e

git fetch --all

git checkout --force "origin/main"

docker compose --env-file ./.env.deploy -f docker-compose.deploy.yml pull

docker compose --env-file ./.env.deploy -f docker-compose.deploy.yml up -d --force-recreate

docker image ls --filter "reference=becagis/docs" --filter "dangling=true" -q | xargs --no-run-if-empty docker rmi