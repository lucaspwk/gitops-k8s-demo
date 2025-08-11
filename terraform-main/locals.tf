locals {
  argocd_values_yaml_path   = "${path.module}/yamls/argocd-values.yaml"
  argocd_apps_dev_yaml_path = "${path.module}/yamls/argocd-apps-dev.yaml"
  argocd_apps_stag_yaml_path = "${path.module}/yamls/argocd-apps-stag.yaml"
  argocd_apps_prod_yaml_path = "${path.module}/yamls/argocd-apps-prod.yaml"

  argocd_values = templatefile(local.argocd_values_yaml_path, {
    release_name                   = var.release_name
  })

}
