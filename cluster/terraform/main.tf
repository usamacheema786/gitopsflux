# kind cluster creation with basic config
resource "kind_cluster" "default" {
  name            = var.cluster_name
  node_image      = var.node_image
  kubeconfig_path = var.kubeconfig_path
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role                   = "control-plane"
      kubeadm_config_patches = local.kubeadm_patch
    }
    networking {
      pod_subnet          = var.pod_subnet
      service_subnet      = var.service_subnet
      disable_default_cni = false
      api_server_address  = "0.0.0.0"
      api_server_port     = var.api_server_port
    }
  }
}

resource "kubernetes_namespace" "staging" { #namespace for staging app
  depends_on = [kind_cluster.default]
  metadata {
    name = "staging"
    labels = {
      "pod-security.kubernetes.io/enforce"         = "restricted"   #Pod Security Admission labels
      "pod-security.kubernetes.io/enforce-version" = "latest"
    }
  }
}

# creating namespace for logging
resource "kubernetes_namespace" "logging" {
  depends_on = [kind_cluster.default]
  metadata {
    name = "logging"
    labels = {
      "pod-security.kubernetes.io/enforce"         = "restricted" #Pod Security Admission labels
      "pod-security.kubernetes.io/enforce-version" = "latest"
    }
  }
}

#creating namespace for monitoring
resource "kubernetes_namespace" "monitoring" {
  depends_on = [kind_cluster.default]
  metadata {
    name = "monitoring"
    labels = {
      "pod-security.kubernetes.io/enforce"         = "restricted" #Pod Security Admission labels
      "pod-security.kubernetes.io/enforce-version" = "latest"
    }
  }
}


