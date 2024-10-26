#!/bin/sh
set -e

color_success=$'\033[0;32m'
color_info=$'\033[0;33m'
color_none=$'\e[0m'

set -o allexport; source .env; set +o allexport

printf '🏊  argo-cd bootstrap, started\n'

sleep 1
if ! kubectl get namespace/argocd
then
    kubectl create namespace argocd
    printf "🏊  argo-cd bootstrap, namespace created\n"
else
    printf "🏊  argo-cd bootstrap, namespace create task skipped\n"
fi

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

if ! kubectl get ing argocd-server-ingress --namespace=argocd
then
    kubectl create -n argocd -f '.cd/root/templates/argocd-ingress.yaml'
    printf "🏊  argo-cd ingress installed\n"
else
    printf "🏊  argo-cd ingress install skipped\n"
fi

printf "🏊  argo-cd bootstrap, installed argo cd application\n"

status=$(minikube status --format={{.Host}}) 

printf "🏄  status: ${status}"

login_username='admin'
login_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

printf "🏊  completed by:\n"
printf "🏄  ${color_info}argo-cd url: https://localhost:8080\n"
printf "🏄  argo-cd username: ${login_username}\n"
printf "🏄  argo-cd password: ${login_password}\n\n"