output "id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.host.id
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance."
  value       = aws_instance.host.availability_zone
}

output "public_ip" {
  description = "The public IP address assigned to the EC2 instances."
  value       = aws_instance.host.public_ip
}

output "security_groups" {
  description = "List of security group associated with the EC2 instance."
  value       = aws_instance.host.security_groups
}

output "vpc_security_group_ids" {
  description = "List of security groups associated with the EC2 instances (if hosted in a non-default VPC)."
  value       = aws_instance.host.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of subnet IDs associated with the EC2 instance."
  value       = aws_instance.host.subnet_id
}

output "tags" {
  description = "List of tags associated with the EC2 instance."
  value       = aws_instance.host.tags
}
