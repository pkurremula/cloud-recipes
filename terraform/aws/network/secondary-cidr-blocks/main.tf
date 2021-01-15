terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  instance_tenancy               = "default"
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = false
  enable_classiclink_dns_support = false

  tags = merge(var.tags, {
    Name      = var.name
    Terraform = true
    Env       = var.env
  })
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary" {
  count      = length(var.secondary_cidr_blocks)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.secondary_cidr_blocks, count.index)
}
