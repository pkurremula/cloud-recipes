output "arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}

output "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks."
  value       = aws_vpc_ipv4_cidr_block_association.secondary.*.cidr_block
}
