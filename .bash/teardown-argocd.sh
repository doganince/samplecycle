#!/bin/sh
set -e

color_success=$'\033[0;32m'
color_info=$'\033[0;33m'
color_none=$'\e[0m'

set -o allexport; source .env; set +o allexport

printf '🏊  argo-cd uninstall, started\n'

kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl delete -n argocd -f 'ci-cd/charts/argo-cd/ingress.yaml'
printf "🏊  argo-cd bootstrap, installed\n"