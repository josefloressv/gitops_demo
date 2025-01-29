provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(module.eks.certificate_authority)
}

# Connect to the EKS cluster
provider "helm" {
  kubernetes {
    host                   = module.eks.endpoint
    token                  = data.aws_eks_cluster_auth.main.token
    cluster_ca_certificate = base64decode(module.eks.certificate_authority)
  }
}
