#region Dinamically from deploy-infra.sh
variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the resources"
}

#endregion

#region VPC
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

#endregion

#region EKS cluster
variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version for the EKS cluster"
}
#endregion

#region Node group
variable "instance_types" {
  type        = list(string)
  description = "The instance types for the EKS node group"
}

variable "node_scaling_config" {
  type        = map(number)
  description = "The scaling configuration for the EKS node group"
}

#endregion

#region Helm
variable "argocd_chart_version" {
  type        = string
  description = "The version of ArgoCD to deploy"
}
#endregion