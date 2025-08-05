resource "kubernetes_manifest" "argocd_apps_dev" {
  manifest = yamldecode(file(local.argocd_apps_dev_yaml_path))

  depends_on = [
    helm_release.argocd
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.argocd_apps_dev_yaml_path)
      error_message = " --> Error: Failed to find '${local.argocd_apps_dev_yaml_path}'. Exit terraform process."
    }
  }
}

resource "kubernetes_manifest" "argocd_apps_stag" {
  manifest = yamldecode(file(local.argocd_apps_stag_yaml_path))

  depends_on = [
    helm_release.argocd
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.argocd_apps_stag_yaml_path)
      error_message = " --> Error: Failed to find '${local.argocd_apps_stag_yaml_path}'. Exit terraform process."
    }
  }
}

resource "kubernetes_manifest" "argocd_apps_prod" {
  manifest = yamldecode(file(local.argocd_apps_prod_yaml_path))

  depends_on = [
    helm_release.argocd
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.argocd_apps_prod_yaml_path)
      error_message = " --> Error: Failed to find '${local.argocd_apps_prod_yaml_path}'. Exit terraform process."
    }
  }
}