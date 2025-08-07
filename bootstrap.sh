#!/bin/bash
set -e
echo "Initializing and applying Terraform..."
terraform -chdir=terraform-main init
terraform -chdir=terraform-main apply -auto-approve

echo "Cluster and Argo CD installation complete!"

for file in ./terraform-main/yamls/argocd-apps-*.yaml; do
  echo "Applying $file"
  minikube kubectl -- apply -f "$file"
done

minikube kubectl -- port-forward svc/argocd-server -n argocd 8080:80 &
echo "ArgoCD port-fowarding done - http://localhost:8080"

echo "Bootstrapping complete!"


