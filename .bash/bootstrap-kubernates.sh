#!/bin/sh
set -e

color_success=$'\033[0;32m'
color_info=$'\033[0;33m'
color_none=$'\e[0m'

set -o allexport; source .env; set +o allexport

printf '🏊  minikube bootstrap, started\n'

if ! which minikube > /dev/null; 
then
  brew install minikube
  printf '🏊  minikube installed\n'
else
  printf "🏊  ${color_info}minikube already installed, skip task${color_none}\n"
fi

minikube start --cpus 6 --memory=4000
minikube addons enable ingress

status=$(minikube status -o=json)

printf "\n\n\n"

printf "${color_success}🚤 SUMMARY\t${color_none}\n"
printf "status\t: ${status}\n"
printf "help\t: use -minikube tunnel- bash to enable local ingress"