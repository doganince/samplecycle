#!/bin/sh
set -e
set -o allexport; source .env; set +o allexport

pushd "./charts-monitoring"

helm upgrade --install elastic --values='./elastic/values.yaml' 'elastic' --wait
helm upgrade --install kibana --values='./kibana/values.yaml' 'kibana' --wait

elastic_endpoint='https://elastic.local.com'
elastic_user=$(kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.username}' | base64 -d)
elastic_password=$(kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d)

printf "\n\n"
printf "${color_success}🚤 SUMMARY\t${color_none}\n"
printf "elastic endpoint\t: ${elastic_endpoint}\n"
printf "elastic password\t: ${elastic_user}\n"
printf "elastic username\t: ${elastic_password}\n"