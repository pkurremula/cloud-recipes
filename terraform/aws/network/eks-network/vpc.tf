# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------

data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name                                        = "${var.prefix}-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  })
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.default.default_network_acl_id

  tags = merge(var.tags, {
    Name = "${var.prefix}-dacl"
  })
}
