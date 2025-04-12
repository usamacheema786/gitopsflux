variable "git_url" {
  description = "Git repository URL used by Flux."
  type        = string
  default     = "https://github.com/usamacheema786/flux-kind-gitops.git"
}

variable "git_username" {
  description = "Username for Git authentication."
  type        = string
  sensitive   = true
  default = "usamacheema786"
}

variable "git_password" {
  description = "Password or token for Git authentication."
  type        = string
  sensitive   = true
}

locals {
  kustomization_yaml = <<YAML
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: staging-app
  namespace: staging
spec:
  interval: 1m
  path: "./apps"
  prune: true
  sourceRef:
    kind: GitRepository
    name : flux-system
    namespace : flux-system
YAML

  kustomization_manifest = yamlencode(yamldecode(local.kustomization_yaml))
}
