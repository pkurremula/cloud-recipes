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

output "private_subnet_ids" {
  description = "List of private subnet IDs."
  value       = aws_subnet.private.*.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs."
  value       = aws_subnet.public.*.id
}
