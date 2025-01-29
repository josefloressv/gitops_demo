#region General
variable "tags" {
  type        = map(string)
  description = "The tags for the resources"
}

variable "name_suffix" {
  type        = string
  description = "The suffix for the resources"
  default     = ""
}

#endregion

#region EKS cluster
variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version for the EKS cluster"
  default     = "1.31"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID for the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs for the EKS cluster"
}

#endregion

#region Node group
variable "instance_types" {
  type        = list(string)
  description = "The instance types for the EKS node group"
  default     = ["t3.medium"]
}

variable "node_scaling_config" {
  type        = map(number)
  description = "The scaling configuration for the EKS node group"
  default = {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
}

#endregion