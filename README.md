# Sample Cycle

A standard style for README files

## Install

```sh
# terraform spin-up > infrastructure/terraform
$ terraform init
$ terraform plan
$ terraform apply
```

```sh
# kubernates spin-up > .bash/
$ bash .bash/bootstrap-kubernates.sh
$ bash .bash/bootstrap-monitoring.sh
$ bash .bash/uninstall-kubernates.sh
```

```sh
# argocd spin-up > .bash/
$ bash bootstrap-argocd.sh
$ bash deploy-app-charts.sh
$ bash uninstall-argocd.sh
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