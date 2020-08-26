terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
}

locals {
  ssh_key_name = "id-terraform-rsa"
}

// Query the latest Amazon Linux AMI.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm.*-ebs"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

// SSH keypair.
resource "aws_key_pair" "default" {
  key_name   = local.ssh_key_name
  public_key = file("${path.cwd}/${local.ssh_key_name}.pub")
}

// EC2 host.
resource "aws_instance" "host" {
  // Use the specified AMI if it's passed as a variable, otherwise use the latest
  // Amazon Linux AMI for the region.
  ami = var.ami_id == "" ? data.aws_ami.amazon_linux.id : var.ami_id

  instance_type   = var.instance_type
  key_name        = local.ssh_key_name

  // This assumes that we are using the default VPC. If you are using a non-default
  // VPC, use `vpc_security_group_ids`.
  security_groups = [aws_security_group.http.name]

  tags = {
    "Name" = var.instance_name
  }
}
