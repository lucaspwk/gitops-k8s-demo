resource "minikube_cluster" "docker" {
  driver       = var.driver
  cluster_name = var.cluster_name
  addons       = var.addons
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "nginx-example"
    labels = {
      App = "NginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "NginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "NginxExample"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}