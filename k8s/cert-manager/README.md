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

### ACME(Let's Encrypt)

#### Create Issuer
```bash
kubectl apply -f issuer/letsencrypt
kubectl get issuer -A
```

#### Deploy sample app
```bash
kubectl apply -f sample.yaml
```

#### Create Ingress
```bash
kubectl apply -f ingress-acme.yaml
```

#### Check Certificate
```bash
kubectl get certificate -A
```

### Vault

#### Configure Vault PKI
```bash
vault write pki/config/urls \
    issuing_certificates="http://vault.default.svc.cluster.local:8200/v1/pki/ca" \
    crl_distribution_points="http://vault.default.svc.cluster.local:8200/v1/pki/crl"
vault write pki/roles/example-dot-com \
    allowed_domains=example.com \
    allow_subdomains=true \
    max_ttl=72h
vault policy write pki - <<EOF
path "pki*"                        { capabilities = ["read", "list"] }
path "pki/roles/example-dot-com"   { capabilities = ["create", "update"] }
path "pki/sign/example-dot-com"    { capabilities = ["create", "update"] }
path "pki/issue/example-dot-com"   { capabilities = ["create"] }
EOF
```

#### Configure Vault Kubernetes authentication
```bash
vault auth enable kubernetes
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
vault write auth/kubernetes/role/issuer \
    bound_service_account_names=issuer \
    bound_service_account_namespaces=default \
    policies=pki \
    ttl=20m
```

#### Create Service Account issuer
```bash
kubectl create serviceaccount issuer
export ISSUER_SECRET_REF=$(kubectl get serviceaccount issuer -o json | jq -r ".secrets[].name")
```

#### Create Issuer
```
envsubst < issuer/vault/issuer.yaml | kubectl apply -f -
kubectl get issuer -A
```

#### Deploy sample app
```bash
kubectl apply -f sample.yaml
```

#### Create Certificate
```bash
kubectl apply -f cert-vault.yaml
```

#### Create Ingress
```bash
kubectl apply -f ingress-vault.yaml
```

#### Check Certificate
```bash
kubectl get certificate -A
```

