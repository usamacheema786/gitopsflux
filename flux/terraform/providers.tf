# flux provider config
provider "flux" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
  git = {
    url = var.git_url
    http = {
      username = var.git_username
      password = var.git_token
    }
  }
}

# kubernetes provider config
provider "kubernetes" {
  config_path = var.kubeconfig_path
  experiments {
    manifest_resource = true
  }
}