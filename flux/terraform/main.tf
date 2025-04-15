#bootstapping flux with git on cluster
resource "flux_bootstrap_git" "this" {
  path     = "flux/clusters/kind"
  interval = "1m"

}

#creating kustomization file for staging in specified directory
resource "local_file" "staging_kustomize" {
  filename   = "../clusters/kind/staging.yaml"
  content    = local.kustomization_yaml
  depends_on = [flux_bootstrap_git.this]
}


