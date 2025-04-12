# main.tf
terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = "../kubeconfig"
}
provider "kind" {}

resource "kind_cluster" "default" {
  name            = var.cluster_name
  node_image      = var.node_image
  kubeconfig_path = var.kubeconfig_path
  wait_for_ready  = true

  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "control-plane"
      kubeadm_config_patches = [<<EOF
kind: ClusterConfiguration
apiServer:
  extraArgs:
    authorization-mode: "Node,RBAC"
controllerManager:
  extraArgs:
    bind-address: "0.0.0.0"
scheduler:
  extraArgs:
    bind-address: "0.0.0.0"
EOF
      ]
    }
    networking {
      pod_subnet           = "10.244.0.0/16"
      service_subnet       = "10.96.0.0/12"
      disable_default_cni  = false
      api_server_address   = "0.0.0.0"
      api_server_port      = 6443
    }
  }
  }


# Apply basic RBAC for default service account in default namespace
resource "kubernetes_cluster_role_binding" "default_view" {
  depends_on = [kind_cluster.default]

  metadata {
    name = "default-view"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}

# Create a NetworkPolicy to restrict pod-to-pod communication
resource "kubernetes_network_policy" "default_deny" {
  depends_on = [kind_cluster.default]

  metadata {
    name      = "default-deny"
    namespace = "default"
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

