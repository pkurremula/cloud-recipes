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

output "bastion_dns_name" {
  description = "The dns name of the bastion."
  value       = aws_instance.bastion.public_dns
}

output "test_private_ip" {
  description = "The IP address of the test host."
  value       = aws_instance.test.private_ip
}
