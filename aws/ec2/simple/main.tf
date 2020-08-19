terraform {
  required_version = ">= 0.12.29"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm.*-ebs"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "host" {
  ami = var.ami_id == "" ? data.aws_ami.amazon_linux.id : var.ami_id
  instance_type = var.instance_type
}
