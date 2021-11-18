output "vpc" {
  description = "VPC"
  value = {
    id         = aws_vpc.default.id
    arn        = aws_vpc.default.arn
    cidr_block = aws_vpc.default.cidr_block
  }
}

output "nat_gateway" {
  description = "NAT"
  value = {
    public_subnet_ids = aws_subnet.public.*.id
    private_subnet_ids = aws_subnet.private.*.id
  }
}
