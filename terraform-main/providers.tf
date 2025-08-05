provider "minikube" {
  kubernetes_version = "v1.30.0"
}

provider "kubernetes" {
  host                   = module.minikube_cluster.host
  client_certificate     = module.minikube_cluster.client_certificate
  client_key             = module.minikube_cluster.client_key
  cluster_ca_certificate = module.minikube_cluster.cluster_ca_certificate
}

provider "helm" {
  kubernetes = {
    host                   = module.minikube_cluster.host
    client_certificate     = module.minikube_cluster.client_certificate
    client_key             = module.minikube_cluster.client_key
    cluster_ca_certificate = module.minikube_cluster.cluster_ca_certificate
  }
}