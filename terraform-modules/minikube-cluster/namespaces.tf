resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  
  metadata {
    name = each.key
    labels = each.value.labels
    annotations = each.value.annotations
  }
}