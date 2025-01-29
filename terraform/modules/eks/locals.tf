locals {
  policies    = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
  name_prefix = length(var.name_suffix) > 0 ? "${var.tags["Application"]}-${var.tags["Environment"]}-${var.name_suffix}" : "${var.tags["Application"]}-${var.tags["Environment"]}"
}
