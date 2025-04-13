# 🚀 Sample Cycle

A standard style for README files

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- Docker
- Kubernetes
- Minikube
- Helm
- Terraform

## 🛠 Setup

### 1. Bootstrap Local Workspace

Ensure your local workspace is ready by running the following script:

```sh
bash ./.bash/bootstrap-local-workspace.sh
```

### 2. Install Infrastructure

Spin up the infrastructure using Terraform:

```sh
# Navigate to the Terraform directory
cd infrastructure/terraform

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the deployment
terraform apply
```

### 3. Kubernetes Setup

Spin up the Kubernetes cluster using Minikube:

```sh
# Start Minikube
bash ./.bash/bootstrap-minikube.sh

# Teardown Minikube
bash ./.bash/teardown-minikube.sh
```

### 4. ArgoCD Setup

Bootstrap ArgoCD and deploy applications:

```sh
# Bootstrap ArgoCD
bash ./.bash/bootstrap-argocd.sh

# Deploy application charts
bash ./.bash/deploy-app-charts.sh

# Teardown ArgoCD
bash ./.bash/teardown-argocd.sh
```

### 5. Local Kubernetes Deployment

Deploy the application to the local Kubernetes cluster:

```sh
# Install the application
helm upgrade --install my-test-app-release . --kube-apiserver=https://kubernetes.docker.internal:6443

# Uninstall the application
helm uninstall my-test-app-release

# Dry run the installation
helm upgrade --install my-test-app-release . --namespace=local --debug --dry-run
```

## 🌐 Local DNS Configuration

Add the following entries to your `/etc/hosts` file for local DNS resolution:

```sh
127.0.0.1	kubernetes.dashboard.domain.com
127.0.0.1	argocd.domain.com
127.0.0.1	core-api.domain.com
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

### [DRY-RUN-SEMANTIC] 
```sh
bash dotenv -e .env -- npx semantic-release --extends ./.release.config.js --debug --branches main --generate-notes
```

## 🚀 Planned Features

Here are some features that are planned for the near future:

- Add Trivy scan for all Docker images to ensure security compliance.
- Enhance CI/CD pipeline with additional testing stages.
- Integrate monitoring and alerting using Prometheus and Grafana.
