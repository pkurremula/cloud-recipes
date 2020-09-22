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

resource "aws_subnet" "public" {
  count  = length(var.public_subnets)
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.public_subnets[count.index], "cidr")
  availability_zone       = lookup(var.public_subnets[count.index], "az")
  map_public_ip_on_launch = lookup(var.public_subnets[count.index], "map_public_ip")

  tags = merge(var.tags, {
    Name      = lookup(var.public_subnets[count.index], "name")
    VPC       = var.name
    Terraform = true
    Env       = var.env
  })
}

resource "aws_subnet" "private" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id

  cidr_block        = lookup(var.private_subnets[count.index], "cidr")
  availability_zone = lookup(var.private_subnets[count.index], "az")

  tags = merge(var.tags, {
    Name      = lookup(var.private_subnets[count.index], "name")
    VPC       = var.name
    Terraform = true
    Env       = var.env
  })
}
