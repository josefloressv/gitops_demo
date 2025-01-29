locals {
  environment = terraform.workspace
  tags = {
    Application    = "gitops"
    Environment    = local.environment
    ProvissionedBy = "Terraform"
  }
}