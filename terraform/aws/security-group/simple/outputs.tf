output "security_groups" {
  description = "IDs of the security groups."
  value       = [
    {
      name = aws_security_group.embedded.name
      id   = aws_security_group.embedded.id
    },
    {
      name = aws_security_group.associated.name
      id   = aws_security_group.associated.id
    }
  ]
}
