# Output kind kubeconfig
output "kind_kubeconfig" {
  value     = kind_cluster.default.kubeconfig
  sensitive = true
}
