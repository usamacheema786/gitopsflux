locals {
  kustomization_yaml = <<YAML
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: staging-app
  namespace: flux-system
spec:
  interval: 1m
  path: "./apps/environments/staging/nginx"
  targetNamespace: staging
  prune: true
  healthChecks:  # healthCheck to perform auto rollback when health check fails
    - apiVersion: apps/v1
      kind: Deployment
      name: nginx
      namespace: staging
  timeout: 2m
  retryInterval: 30s
  sourceRef:
    kind: GitRepository
    name : flux-system
    namespace : flux-system
YAML

  kustomization_manifest = yamldecode(local.kustomization_yaml)
}
