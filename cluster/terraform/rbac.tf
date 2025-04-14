resource "kubernetes_service_account" "nginx" {
  metadata {
    name      = "nginx-sa"
    namespace = kubernetes_namespace.staging.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "nginx_read_only" {
  metadata {
    name = "nginx-read-only"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "nginx_binding" {
  metadata {
    name = "nginx-readonly-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.nginx_read_only.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.nginx.metadata[0].name
    namespace = kubernetes_namespace.staging.metadata[0].name
  }
}
