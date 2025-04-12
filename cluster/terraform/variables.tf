# variables.tf
variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "flux-demo-cluster"
}

variable "node_image" {
  description = "Kind node image to use for the cluster"
  type        = string
  default     = "kindest/node:v1.27.3"
}

variable "kubeconfig_path" {
  description = "Path where the kubeconfig file will be saved"
  type        = string
  default = "../kubeconfig"
  #default     = "~/.kube/config"
}