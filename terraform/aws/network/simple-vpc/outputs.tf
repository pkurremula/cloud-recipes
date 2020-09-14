output "arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}
