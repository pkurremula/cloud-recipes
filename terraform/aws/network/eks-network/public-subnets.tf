resource "aws_subnet" "public" {
  count = length(var.subnets.public_cidrs)

  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.subnets.public_cidrs, count.index)
  availability_zone = element(local.azs, count.index)

  tags = merge(var.tags, {
    Name                                        = "${var.prefix}-${local.azs[count.index]}-public-subnet"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  })
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = compact(flatten([aws_subnet.public.*.id]))

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
  }
}

# Elastic IP address (for NAT)

resource "aws_eip" "nat" {
  vpc = true

  tags = merge(var.tags, {
    Name = "${var.prefix}-eip"
  })
}

# NAT

# 1 NAT for all subnets.
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = merge(var.tags, {
    Name = "${var.prefix}-nat"
  })
}

# Internet Gateway

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = merge(var.tags, {
    Name = "${var.prefix}-ig"
  })
}

# Routing

# 1 route table for all public subnets.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = merge(var.tags, {
    Name = "${var.prefix}-public-rt"
  })
}

resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route_table_association" "public" {
  count = length(var.subnets.public_cidrs)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
