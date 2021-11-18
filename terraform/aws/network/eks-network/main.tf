terraform {
  required_version = "~> 1.0.11"

  required_providers {
    aws = {
      source = "aws"

      # Check https://registry.terraform.io/providers/hashicorp/aws/latest for versions.
      version = "~> 3.65.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
