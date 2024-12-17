# Sample Cycle

A standard style for README files

## After repo is download follow step at below to ensure local workspace is ready 
bash ./.bash/bootstrap-local-workspace.sh



## Install

```sh
# terraform spin-up > infrastructure/terraform
$ terraform init
$ terraform plan
$ terraform apply
```

```sh
# kubernates spin-up > .bash/
$ bash ./.bash/bootstrap-minikube.sh
$ bash ./.bash/teardown-minikube.sh
```

```sh
# argocd spin-up > .bash/
$ bash bootstrap-argocd.sh
$ bash deploy-app-charts.sh
$ bash teardown-argocd.sh
```

```sh
# local kubernates spin-up
helm upgrade --install my-test-app-release . --kube-apiserver=https://kubernetes.docker.internal:6443
helm uninstall my-test-app-release
helm upgrade --install my-test-app-release . --namespace=local --debug --dry-run
```

```sh
# happy path 
$ bash .bash/bootstrap-kubernates.sh
$ bash .bash/bootstrap-monitoring.sh
```

```sh
# local dns 
127.0.0.1	kubernetes.dashboard.domain.com
127.0.0.1	argocd.domain.com
```
