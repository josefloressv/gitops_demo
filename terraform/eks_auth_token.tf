data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name
}
