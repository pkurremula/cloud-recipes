resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.default.id

  ingress {
    description = "Ingress firewall rules for the default security group."
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
  }

  egress {
    description = "Egress firewall rules for the default security group."
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
  }
}
