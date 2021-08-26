# Consul

## Installation

### Prerequisites
- Kubernetes Cluster (e.g. Minkube)
- `kubectl`
- `helm`

### Using Helm chart

#### Add HashiCorp Helm repository
```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
```

#### Update Helm repositories
```bash
helm repo update
```

#### Install Helm chart
```bash
helm install consul hashicorp/consul --version 0.33.0 --values helm-values.yaml
```
`helm-values.yaml` is prepared for use on Minikube not for production env.
