resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argocd" {
  namespace        = var.namespace
  name             = var.chart_name
  
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.2"
  
  create_namespace = var.create_namespace
  wait             = true

  values = [
    local.argocd_values
  ]

  depends_on = [
    kubernetes_namespace.namespace
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.values_yaml_path)
      error_message = " --> Error: Failed to find '${local.values_yaml_path}'. Exit terraform process."
    }
  }
}

