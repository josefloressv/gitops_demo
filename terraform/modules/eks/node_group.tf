resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.name_prefix}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types

  scaling_config {
    desired_size = var.node_scaling_config["desired_size"]
    max_size     = var.node_scaling_config["max_size"]
    min_size     = var.node_scaling_config["min_size"]
  }

  lifecycle {
    ignore_changes = [
    scaling_config[0].desired_size, ]
  }

  tags = var.tags
}
