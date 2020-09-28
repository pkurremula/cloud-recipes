terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
}

resource "aws_security_group" "icmp" {
  name        = "icmp-sg"
  description = "Allows incoming icmp ping."
  tags = {
    Terraform = true
  }

  ingress {
    from_port = 8
    protocol = "icmp"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
