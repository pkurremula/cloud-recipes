# Private Subnet

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(local.azs, count.index)

  tags = merge(var.tags, {
    Name = "${var.prefix}${local.azs[count.index]}-private-subnet"
  })
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.default.id
  subnet_ids = compact(flatten([aws_subnet.private.*.id]))

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

# Private Subnet Routing

# Only 1 route table for all public subnets.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  tags = merge(var.tags, {
    Name = "${var.prefix}-private-rt"
  })
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}
