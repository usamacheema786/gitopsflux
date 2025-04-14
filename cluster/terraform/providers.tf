provider "kubernetes" { #generating kubeconfig file for testing purpose
  config_path = "../kubeconfig"
}
provider "kind" {}
