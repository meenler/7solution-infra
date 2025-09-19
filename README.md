# 7solution-infra

This repository contains the Kubernetes manifests and GitOps configuration for deploying the **go-app** service using **Kustomize** and **ArgoCD**.

## 📂 Repository Structure

```
7solution-infra/
├── base/
│   ├── deployment.yaml      # Deployment for go-app
│   ├── service.yaml         # Service exposing go-app
│   ├── ingress.yaml         # Ingress configuration
│   ├── hpa.yaml             # Horizontal Pod Autoscaler
│   └── kustomization.yaml   # Base Kustomize file
│
├── overlays/
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   ├── patch-dev.yaml
│   │   └── namespace.yaml
│   │
│   └── prod/
│       ├── kustomization.yaml
│       ├── patch-prod.yaml
│       └── namespace.yaml
│
├── argo-apps/
│   ├── argo-app-dev.yaml    # ArgoCD Application for dev
│   └── argo-app-prod.yaml   # ArgoCD Application for prod
│
└── README.md
```

## 🚀 How It Works

- **Base manifests** (in `base/`) define the common configuration for the go-app service.
- **Overlays** (in `overlays/dev` and `overlays/prod`) patch the base with environment-specific changes such as replicas, image tags, and namespaces.
- **ArgoCD Applications** (in `argo-apps/`) point to each overlay, allowing GitOps-driven deployments.

## 🔧 Usage

### Build manifests with Kustomize for check manifests
```bash
kustomize build overlays/dev
kustomize build overlays/prod
```


### Apply locally with Kustomize
```bash
kubectl apply -k overlays/dev
kubectl apply -k overlays/prod
```

### Deploy with ArgoCD
1. Apply the ArgoCD Application manifest:
   ```bash
   kubectl apply -f argo-apps/argo-app-dev.yaml -n argocd
   kubectl apply -f argo-apps/argo-app-prod.yaml -n argocd
   ```
2. ArgoCD will automatically sync the manifests to the cluster.

## 📝 Notes

- Default image is `peerasilp/7solution-app:'tagname'`.
- Dev/Prod overlays override the base with their own tags and environment variables.
- Namespace manifests (`namespace.yaml`) ensure that the target namespaces exist before deploying workloads.

---
