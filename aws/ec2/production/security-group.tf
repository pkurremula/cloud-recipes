// Security group.
resource "aws_security_group" "http" {
  name        = "http-sg"
  description = "Security for allowing HTTP ingress"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "http_ingress" {
  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "ingress"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.http.id
}
