terraform {
  required_version = "~> 1.0.11"

  required_providers {
    # Check https://registry.terraform.io/providers/hashicorp/aws/latest for versions.
    aws = {
      source = "aws"
      version = "~> 3.66.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
