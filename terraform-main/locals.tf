locals {
  values_yaml_path      = "${path.module}/yamls/values.yaml"
  # app_project_yaml_path = "${path.module}/yamls/app-project.yaml"

  argocd_values = templatefile(local.values_yaml_path, {
    release_name                   = var.release_name
  })

  # app_project_yaml = templatefile(local.app_project_yaml_path, {
  #   namespace    = var.namespace
  # })
}
