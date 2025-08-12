# Cluster Setup

## Tools required

```bash
brew install eksctl
brew install helm
brew install kubectl
brew install yq
brew install jq
brew install mongocli
brew install awscli
brew install k9s (optional - to browse through K8S cluster)
```

## Setup

```bash
eksctl create cluster -f cluster.yaml
```

Add necessary Helm repositories

```bash
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo add jetstack https://charts.jetstack.io
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm repo add eks https://aws.github.io/eks-charts
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

```bash
kubectl apply -f gp3.yaml
```

Install AWS Load Balancer controller

```bash
# REPLACE THIS
CLUSTER_NAME=ald2

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set clusterName=$CLUSTER_NAME
```

Install `external-dns` so that DNS entries in Route 53 is automatically created

```bash
helm upgrade -i external-dns external-dns/external-dns \
  --namespace external-dns \
  --create-namespace \
  --set serviceAccount.create=false \
  --set serviceAccount.name=external-dns \
  --set 'sources[0]=service' \
  --set 'sources[1]=ingress' \
  --set policy=sync \
  --set registry=txt \
  --set txtOwnerId="$CLUSTER_NAME" \
  --set txtPrefix="" \
  --set 'domainFilters[0]=mongosa.net' \
  --set provider.name=aws \
  --set 'extraArgs[0]=--aws-zone-type=public'
```

Deploy ArgoCD

```bash
helm upgrade -i argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --values values-argocd.yaml
```

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
# Y-yGhb9eOWsKrMwl
```

```bash
argocd login argocd-ald.mongosa.net --username admin
```

```bash
# Read Only access to this repo
argocd repo add https://github.com/aldredb/devops-stuff.git --username aldredb --password <Your Github Personal Access Token>
```
