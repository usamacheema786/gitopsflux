# terraform provider versions to run the module
terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.4"
    }
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}
