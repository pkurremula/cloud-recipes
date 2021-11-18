# -----------------------------------------------------------------------------
# VPC
# -----------------------------------------------------------------------------

locals {
  vpc_name = "${var.prefix}-vpc"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  lifecycle {
    create_before_destroy = true
  }
}

# Public Subnet

resource "aws_subnet" "public" {
  count = length(var.subnets.public_cidrs)

  vpc_id = aws_vpc.default.id
  cidr_block = element(var.subnets.public_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

# Elastic IP address (for NAT)

# IP address for each NAT in the public subnet.
resource "aws_eip" "nat" {
  count = length(var.subnets.public_cidrs)

  vpc = true
}

# NAT

# One NAT per subnet.
resource "aws_nat_gateway" "default" {
  count = length(var.subnets.public_cidrs)

  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id = element(aws_subnet.public.*.id, count.index)
}

# Internet Gateway

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Routing

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route" "internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default.id
}

# Private Subnet

resource "aws_subnet" "private" {
  count = length(var.subnets.private_cidrs)

  vpc_id = aws_vpc.default.id
  cidr_block = element(var.subnets.private_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

# Private Subnet Routing

# Only 1 route table for all public subnets.
resource "aws_route_table" "private" {
  count = length(var.subnets.private_cidrs)

  vpc_id = aws_vpc.default.id
}

# Allows private network to access the Internet.
resource "aws_route" "nat_gateway" {
  count = length(var.subnets.private_cidrs)

  route_table_id = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.default.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.subnets.private_cidrs)

  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id = element(aws_subnet.private.*.id, count.index)
}
