locals {
  bastion_hostname       = "bastion"
  bastion_ssh_key_name   = "bastion_ssh"
  bastion_ssh_file       = "id-rsa-bastion"
  bastion_user_data_file = "user-data.sh"
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
  key_name   = local.bastion_ssh_key_name
  public_key = file("${path.module}/${local.bastion_ssh_file}.pub")
}

// Security group.
resource "aws_security_group" "ssh" {
  name        = "ssh-sg"
  description = "Allow incoming ssh traffic."
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    protocol = "icmp"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami = var.bastion_ami_id == "" ? data.aws_ami.amazon_linux.id : var.bastion_ami_id

  instance_type = var.bastion_instance_type
  key_name      = local.bastion_ssh_key_name

  subnet_id = element(aws_subnet.public.*.id, 0)

  // Since we are using a custom VPC, we are using `vpc_security_group_ids`. If we are
  // using the default vpc, use `security_groups` instead.
  vpc_security_group_ids = [aws_security_group.ssh.id]

  user_data = base64encode(templatefile("${path.module}/${local.bastion_user_data_file}", {
  }))

  tags = merge(var.tags, {
    Name      = local.bastion_hostname
    Terraform = true
  })
}
