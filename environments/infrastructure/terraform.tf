terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.42.0"
    }

    helm = {
        source  = "hashicorp/helm"
        version = "~> 2.0"
    }
  }
}