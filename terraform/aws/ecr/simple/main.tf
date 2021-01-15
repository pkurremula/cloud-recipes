terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
}

resource "aws_ecr_repository" "repo" {
  name = var.ecr.repo_name

  image_scanning_configuration {
    scan_on_push = var.ecr.scan_on_push
  }

  tags = var.ecr.tags
}

