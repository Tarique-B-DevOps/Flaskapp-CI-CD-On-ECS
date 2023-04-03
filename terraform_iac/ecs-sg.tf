data "aws_subnets" "subnet" {
  filter {
    name = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_security_group" "ecs_sg-all" {
  name        = "flaskapp-ecs-tasks-security-group-for-all"
  description = "allow full access"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}