variable "driver" {
  type        = string
  default     = "docker"
  description = "Minikube cluster driver"
}

variable "addons" {
  type        = list(string)
  default     = [
    "default-storageclass", 
    "storage-provisioner"
  ]
  description = "List of minikube addons to install"
}

variable "namespaces" {
  type = map(object({
    labels         = map(string)
    annotations    = map(string)
  }))
  default = {
    dev-internal = {
      labels = {
        environment = "dev"
        visibility  = "internal"
      }
      annotations = {}
    }

    dev-external = {
      labels = {
        environment = "dev"
        visibility  = "external"
      }
      annotations = {}
    }
    stag-internal = {
      labels = {
        environment = "stag"
        visibility  = "internal"
      }
      annotations = {}
    }

    stag-external = {
      labels = {
        environment = "stag"
        visibility  = "external"
      }
      annotations = {}
    }

    prod-internal = {
      labels = {
        environment = "prod"
        visibility  = "internal"
      }
      annotations = {}
    }

    prod-external = {
      labels = {
        environment = "prod"
        visibility  = "external"
      }
      annotations = {}
    }

    monitoring = {
      labels = {
        purpose = "monitoring"
      }
      annotations = {}
    }
  }
}

variable "release_name" {
  type        = string
  default     = "argocd"
  description = "Name of release"
}
variable "chart_name" {
  type        = string
  description = "Name of the chart to install"
  default     = "argo-cd"
}
variable "chart_version" {
  type        = string
  description = "Version of the chart to install"
  default     = "8.2.5"
}
variable "repository" {
  type        = string
  description = "Repository to install the chart from"
  default     = "https://argoproj.github.io/argo-helm"
}
variable "namespace" {
  type        = string
  default     = "argocd"
  description = "Namespace to install the chart into"
}
variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name to install the chart into"
  default     = "argocd"
}
variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not exist"
  default     = false
}