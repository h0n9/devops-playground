# K3D Configuration

## Prerequisites

- docker
- k3d 
- k9s (recommended)

## Create Cluster

- CNI: calico

### Using `config.yaml`

```bash
k3d cluster create <cluster-name> --config config.yaml
```
