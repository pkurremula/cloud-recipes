terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
}

// There are 2 ways to define an AWS security group:
// 1. Standalone `aws_security_group`.
// 2. `aws_security_group` with associated `aws_security_group_rule`.

// Define a `aws_security_group` resource module and embed the ingress/regress rules within.

resource "aws_security_group" "embedded_rules_sg" {
  name        = "embedded-sg"
  description = "Security group with embedded ingresses and egresses."
  tags = {
    "Terraform-managed" = true
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


// 2. Define a `aws_security-group` resource module and associate it with multiple `aws_security_group_rule` modules.

resource "aws_security_group" "associated_rules_sg" {
  name        = "associated-sg"
  description = "Security group with ingresses and egresses are defined by the aws_security_group_rule modules."
  tags = {
    "Terraform-managed" = true
  }
}

resource "aws_security_group_rule" "http_ingress" {
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  type      = "ingress"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.associated_rules_sg.id
}

resource "aws_security_group_rule" "all_egress" {
  from_port   = 0
  to_port     = 0
  protocol    = "all"
  type        = "egress"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.associated_rules_sg.id
}
