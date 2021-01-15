terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  region  = var.region
  version = "~> 3.2.0"
  profile = "cloud-recipes"
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

// EC2 host.
resource "aws_instance" "host" {
  ami           = var.vm.ami_id == "" ? data.aws_ami.amazon_linux.id : var.vm.ami_id
  instance_type = var.vm.instance_type

  count     = var.vm.instance_count
  subnet_id = element(var.vm.subnet_ids, count.index)

  tags = merge(var.vm.tags, {
    Name      = "${var.vm.instance_prefix}-${count.index}"
    Terraform = true
  })
}
