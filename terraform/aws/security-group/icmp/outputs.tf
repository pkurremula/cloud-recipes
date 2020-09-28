output "security_groups" {
  description = "The ID of the icmp security group."
  value = aws_security_group.icmp.id
}
