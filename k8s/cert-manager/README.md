# Cert-manager 

## Installation

### Prerequisites
- Kubernetes Cluster (e.g. Minkube)
- `kubectl`
- `helm`

### Using Helm chart

#### Add Jetstack Helm repository
```bash
helm repo add jetstack https://charts.jetstack.io
```

#### Update Helm repositories
```bash
helm repo update
```

#### Install Helm chart
```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.3 \
  --values helm-values.yaml
```
`helm-values.yaml` is prepared for use on Minikube not for production env.

## Usage

### Setup Issuer

#### Create Issuer for staging, prd
```
kubectl apply -f issuer-*.yaml
```


