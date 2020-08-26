output "security_groups" {
  description = "IDs of the security groups."
  value       = [
    {
      name = aws_security_group.embedded_rules_sg.name
      id   = aws_security_group.embedded_rules_sg.id
    },
    {
      name = aws_security_group.associated_rules_sg.name
      id   = aws_security_group.associated_rules_sg.id
    }
  ]
}
