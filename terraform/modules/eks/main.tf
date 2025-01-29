resource "aws_eks_cluster" "main" {
  name     = local.name_prefix
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version
  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = var.tags
}