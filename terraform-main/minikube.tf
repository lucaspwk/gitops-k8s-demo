module "minikube_cluster" {
  source  = "../terraform-modules/minikube-cluster/"
  
  cluster_name = var.cluster_name
  namespaces   = var.namespaces
  driver       = var.driver
  addons       = var.addons
}
