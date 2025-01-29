output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "certificate_authority" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}