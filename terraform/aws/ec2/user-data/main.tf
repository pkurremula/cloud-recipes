terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
}

locals {
  ssh_key_name   = "ec2_prod_ssh"
  ssh_file       = "id-terraform-rsa"
  user_data_file = "user-data.sh"
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
  public_key = file("${path.cwd}/${local.ssh_file}.pub")
}

// Security group.
resource "aws_security_group" "http" {
  name        = "http-sg"
  description = "Security for allowing HTTP ingress"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// EC2 host.
resource "aws_instance" "host" {
  // Use the specified AMI if it's passed as a variable, otherwise use the latest
  // Amazon Linux AMI for the region.
  ami = var.ami_id == "" ? data.aws_ami.amazon_linux.id : var.ami_id

  instance_type = var.instance_type
  key_name      = local.ssh_key_name

  // For terraform 0.12 and above, use the function templatefile instead of
  // data.template_file.
  user_data = base64encode(templatefile("${path.module}/${local.user_data_file}", {
    port         = var.port
    node_version = var.node_version
  }))

  // This assumes that we are using the default VPC. If you are using a non-default
  // VPC, use `vpc_security_group_ids`.
  security_groups = [aws_security_group.http.name]

  tags = merge(var.tags, {
    Name      = var.instance_name
    Terraform = true
  })
}
