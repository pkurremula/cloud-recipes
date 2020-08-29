terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
}

resource "aws_ecr_repository" "repo" {
  name = var.repo_name

  image_scanning_configuration {
    scan_on_push = false
  }
}

