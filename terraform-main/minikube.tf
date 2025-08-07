module "minikube_cluster" {
  source  = "../terraform-modules/minikube-cluster/"
  
  cluster_name = "minikube"
  namespaces   = var.namespaces
  driver       = var.driver
  addons       = var.addons
}
