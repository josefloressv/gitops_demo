module "vpc" {
  source = "./modules/vpc"

  tags     = local.tags
  vpc_cidr = var.vpc_cidr

}

module "eks" {
  source = "./modules/eks"

  kubernetes_version  = var.kubernetes_version
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  instance_types      = var.instance_types
  node_scaling_config = var.node_scaling_config
  tags                = local.tags

}