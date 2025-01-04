#!/bin/sh
set -e

docker compose -f ./iac/local-stack/docker-compose.yaml up -d

printf "Local envoriment completed by:\n"