locals {
  kubeadm_patch = [
    <<EOF
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
