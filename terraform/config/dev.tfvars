vpc_cidr           = "10.0.0.0/16"
kubernetes_version = "1.31"
instance_types     = ["t3.medium"]
node_scaling_config = {
  min_size     = 1
  desired_size = 1
  max_size     = 3
}

# ArgoCD
argocd_chart_version = "5.19.12"