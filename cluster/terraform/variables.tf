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
  default     = "../kubeconfig"
  #default     = "~/.kube/config"
}

variable "pod_subnet" {
  default     = "10.244.0.0/16"
  description = "Pod network CIDR block"
}

variable "service_subnet" {
  default     = "10.96.0.0/12"
  description = "Service network CIDR block"
}

variable "api_server_port" {
  default     = 6443
  description = "API server port"
}
