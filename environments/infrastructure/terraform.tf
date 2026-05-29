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

  backend "s3" {
    bucket = "cicd-bucket-huby71"
    key = "env/dev/terraform.tfstate"
    region = "eu-central-1"
  }
}