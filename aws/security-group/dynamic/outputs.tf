output "security_group" {
  description = "ID of the security groups."
  value       = aws_security_group.dynamic_sg.id
}
