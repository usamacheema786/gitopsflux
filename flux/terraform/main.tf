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

provider "kubernetes" {
  config_path = "../../cluster/kubeconfig"
  experiments {
        manifest_resource = true
    }
}

provider "flux" {
  kubernetes = {
    config_path = "../../cluster/kubeconfig"
  }
  git = {
    url = "https://github.com/usamacheema786/flux-kind-gitops.git"
    http = {
      username = var.git_username
      password = var.git_password
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path     = "flux/clusters/kind"
  interval = "1m"

}

resource "kubernetes_manifest" "flux_apps_kustomization" {
  manifest = local.kustomization_manifest
  /*{
    "apiVersion" = "kustomize.toolkit.fluxcd.io/v1"
    "kind"       = "Kustomization"
    "metadata" = {
      "name"      = "apps"
      "namespace" = "staging"
    }
    "spec" = {
      interval = "1m"
      path     = "../apps"
      prune    = true
      sourceRef = {
        kind = "GitRepository"
        name : flux-system
        namespace : flux-system
      }
    }
  }*/
  depends_on = [flux_bootstrap_git.this]
}

resource "local_file" "staging_kustomize" {
  filename = "${path.module}/flux/clusters/kind/staging.yaml"

}


