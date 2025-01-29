#region EKS outputs
output "eks_name" {
  value = module.eks.cluster_name
}

output "eks_connect" {
  value = "aws eks --region us-east-1 update-kubeconfig --name ${module.eks.cluster_name}"
}
#endregion

#region VPC outputs 
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
#endregion

# region Helm outputs
output "argocd_load_balancer_dns" {
  value = "https://${data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname}"
}

output "argocd_initial_admin_secret" {
  value = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
}
#endregion