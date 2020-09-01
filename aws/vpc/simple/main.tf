terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  // See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_classiclink = false
  enable_classiclink_dns_support = false

  tags = merge(var.tags, {
    "Name" = var.name
    "Terraform" = true
    "Env" = "dev"
  })
}
