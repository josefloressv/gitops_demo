terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.79.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
  }
}