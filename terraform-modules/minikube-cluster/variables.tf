variable "cluster_name" {
  type        = string
  default     = "minikube-hostaway"
  description = "Minikube cluster name"
}

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
  default = {}
}
