variable "git_url" {
  description = "Git repository URL used by Flux."
  type        = string
  default     = "https://github.com/usamacheema786/gitopsflux.git"
}

variable "git_username" {
  description = "Username for Git authentication."
  type        = string
  sensitive   = true
  default     = "usamacheema786"
}

variable "git_token" {
  description = "Password or token for Git authentication."
  type        = string
  sensitive   = true
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file."
  type        = string
  default     = "../../cluster/kubeconfig"
}