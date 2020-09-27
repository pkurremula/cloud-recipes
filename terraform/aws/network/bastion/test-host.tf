// Put an EC2 host in the private subnet for testing.
resource "aws_instance" "test" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.test_instance_type
  key_name      = local.bastion_ssh_key_name

  subnet_id              = element(aws_subnet.private.*.id, 0)
  vpc_security_group_ids = [aws_security_group.ssh.id]
}


