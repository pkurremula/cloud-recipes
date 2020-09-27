terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
}

// --- VPC ---

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  instance_tenancy               = "default"
  enable_dns_hostnames           = true
  enable_dns_support             = true
  enable_classiclink             = false
  enable_classiclink_dns_support = false

  tags = merge(var.tags, {
    Name      = "${var.prefix}-vpc"
    Terraform = true
    Env       = var.env
  })
}

// --- Subnets ---

resource "aws_subnet" "public" {
  count  = length(var.public_subnets)
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(element(var.public_subnets, count.index), "cidr")
  availability_zone       = lookup(element(var.public_subnets, count.index), "az")
  map_public_ip_on_launch = lookup(element(var.public_subnets, count.index), "map_public_ip")

  tags = merge(var.tags, {
    Name      = format("%s-%s", var.prefix, lookup(element(var.public_subnets, count.index), "suffix"))
    Terraform = true
    Env       = var.env
  })
}

resource "aws_subnet" "private" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.vpc.id

  cidr_block        = lookup(element(var.private_subnets, count.index), "cidr")
  availability_zone = lookup(element(var.private_subnets, count.index), "az")

  tags = merge(var.tags, {
    Name      = format("%s-%s", var.prefix, lookup(element(var.private_subnets, count.index), "suffix"))
    Terraform = true
    Env       = var.env
  })
}

// --- Gateway and NAT ---

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name      = "${var.prefix}-igw"
    Terraform = true
    Env       = var.env
  })
}

resource "aws_eip" "nat" {
  vpc = true

  tags = merge(var.tags, {
    Name      = "${var.prefix}-eip"
    Terraform = true
    Env       = var.env
  })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = merge({
    Name = format("%s-%s", var.prefix, lookup(element(var.public_subnets, 0), "az"))
    Terraform = true
    Env       = var.env
  }, var.tags)

  depends_on = [aws_internet_gateway.igw]
}

// --- Routes ---

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name      = "${var.prefix}-publicrt"
    Terraform = true
    Env       = var.env
  })
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name      = "${var.prefix}-privatert"
    Terraform = true
    Env       = var.env
  })
}

// Route table association

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
