output "vpc" {
  description = "VPC"
  value = {
    id         = aws_vpc.default.id
    arn        = aws_vpc.default.arn
    cidr_block = aws_vpc.default.cidr_block
  }
}

output "public_subnet_ids" {
  description = "A list of public subnet ids"
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "A list of private subnet ids"
  value = aws_subnet.private.*.id
}
