# Allow Ingress Only to Pods with app=nginx on Port 80
resource "kubernetes_network_policy" "allow_nginx_ingress" {
  metadata {
    name      = "allow-nginx-ingress"
    namespace = kubernetes_namespace.staging.metadata[0].name
  }

  spec {
    pod_selector {
      match_labels = {
        app = "nginx"
      }
    }

    ingress {
      from {
        ip_block {
          cidr = "0.0.0.0/0"
        }
      }

      ports {
        port     = 80
        protocol = "TCP"
      }
    }

    policy_types = ["Ingress"]
  }
}
