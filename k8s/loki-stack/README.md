# Loki Stack

## Installation

### Prerequisites
- Kubernetes Cluster (e.g. Minkube)
- `kubectl`
- `helm`

### Using Helm chart

#### Add Loki Helm repository
```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

#### Update Helm repositories
```bash
helm repo update
```

#### Install Helm chart
```bash
helm upgrade --install loki grafana/loki-stack --version 2.6.5 --values helm-values.yaml
```
`helm-values.yaml` is set to deploy the following applications with persistent volume claim:
- Loki
- Promtail
- Grafana
- Prometheus

## Usage

### Get admin password for Grafana
```bash
kubectl get secret loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

### Deploy apps
```bash
kubectl apply -R -f poc/
```
