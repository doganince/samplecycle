#!/bin/sh
set -e

color_success=$'\033[0;32m'
color_info=$'\033[0;33m'
color_error=$'\033[1;31m'
color_none=$'\e[0m'

set -o allexport; source .env; set +o allexport

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "$color_info MacOS detected"

    if ! command -v brew &> /dev/null; then
        echo "Homebrew package manager could not found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    echo "$color_noneMinikube installing..."
    brew install minikube
    brew install helm

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "$color_infoLinux detected"
    
    if ! command -v minikube &> /dev/null; then
        echo "$color_none!Minikube installing..."
        sudo apt update -y
        sudo apt install -y curl apt-transport-https virtualbox virtualbox-ext-pack
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
    fi
else
    echo "Unsupported operating system"
    exit 1
fi

minikube start --cpus 6 --memory=4000 --addons=ingress

printf 'minikube dashboard installing'

helm repo remove kubernetes-dashboard 
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard -f ./ci-cd/charts/kubernetes-dashboard/values.yaml
kubectl apply -f ./ci-cd/charts/kubernetes-dashboard/ingress.yaml

login_token=$(kubectl -n kubernetes-dashboard create token default)

printf "$color_success! 🏊  Minikube bootstrap completed"
printf "$color_ınfo access token: $login_token"
printf "$color_none use 'minikube tunnel' bash to enable local ingress"