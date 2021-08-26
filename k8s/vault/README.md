# Vault 

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
helm install vault hashicorp/vault --version 0.15.0 --values helm-values.yaml
```
`helm-values.yaml` is prepared for use on Minikube not for production env.

#### Initialize Vault
```bash
kubectl exec vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
```
Store `cluster-keys.json` in a secure place.

#### Unseal Vault
```bash
kubectl exec vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY
```

## Configure

#### Connect to Vault pod
```bash
kubectl exec --stdin=true --tty=true vault-0 -- /bin/sh
```

#### Enable Kubernetes authentication
```bash
vault login # type token
valut auth enable kubernetes
```

#### Configure Kubernetes authentication
```bash
vault write auth/kubernetes/config \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

## Usage

### Set a secret in Vault

#### Connect to Vault pod
```bash
kubectl exec --stdin=true --tty=true vault-0 -- /bin/sh
```

#### Enable kv-v2 secrets at the path `secret`
```bash
vault login # type token
vault secrets enable -path=secret kv-v2
```

#### Create a secret at path `secret/webapp/config`
```bash
vault kv put secret/webapp/config username="static-user" password="static-password"
vault kv get secret/webapp/config
```

#### Write policy
```bash
vault policy write webapp - <<EOF
path "secret/data/webapp/config" {
  capabilities = ["read"]
}
EOF
```

#### Create Kubernetes authentication role
```bash
vault write auth/kubernetes/role/webapp \
        bound_service_account_names=vault \
        bound_service_account_namespaces=default \
        policies=webapp \
        ttl=24h
```

### Launch a web application

#### Deploy `webapp`
```bash
kubectl apply -f deployment-01-webapp.yaml
```
