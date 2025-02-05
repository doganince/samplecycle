#!/bin/sh
set -e

color_success=$'\033[0;32m'
color_info=$'\033[0;33m'
color_none=$'\e[0m'

set -o allexport; source .env; set +o allexport

printf 'argo cd bootstrap for apps, started\n'

# kubectl port-forward svc/argocd-server -n argocd 8080:443 &

login_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

argocd login argocd.domain.com:443 --username="admin" --password="${login_password}" --insecure
printf "🏊  argo-cd bootstrap, login is successful\n"

argocd repo add $GITHUB_REPO_URL --username $REPOSITORY_USERNAME --password $REPOSITORY_TOKEN_ARGO_CD --name git-sample-cycle --upsert 
printf "${color_success}root app added to argo cd ${color_none}\n"

argocd app create apps \
  --dest-namespace argocd \
  --dest-server $KUBERNATES_SERVICE_URL \
  --repo $GITHUB_REPO_URL \
  --path src/charts/root \
  --insecure \
  --upsert 
  --async &

printf "${color_success}app created successful ${color_none}\n"

printf "${color_info}apps sync started ${color_none}\n"
argocd app sync apps --server=argocd.domain.com:443 --insecure &
printf "${color_success}triggered sync apps ${color_none}\n"

minikube tunnel
printf '🏊  minikube tunnel started \n'

printf "\n\n${color_success}=========================${color_none}\n"
printf "${color_info}argo cd login information ${color_none}\n\n"
printf "url: https://localhost:8080\n"
printf "username: ${login_username}\n"
printf "password: ${login_password}\n\n"

printf "DONE 🏊 ... ${color_none}\n\n"



printf "${color_success}=========================${color_none}\n\n\n"
