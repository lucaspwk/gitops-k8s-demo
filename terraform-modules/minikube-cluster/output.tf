output "host" {
  value = minikube_cluster.docker.host
}

output "client_certificate" {
  value = minikube_cluster.docker.client_certificate
}

output "client_key" {
  value = minikube_cluster.docker.client_key
}

output "cluster_ca_certificate" {
  value = minikube_cluster.docker.cluster_ca_certificate
}
