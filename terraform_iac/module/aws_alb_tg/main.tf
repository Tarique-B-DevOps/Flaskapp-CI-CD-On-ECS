data "aws_subnets" "subnet" {
  filter {
    name = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}
data "aws_vpc" "default" {
  default = true
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_lb" "default" {
  name            = var.alb_name
  subnets         = data.aws_subnets.subnet.ids
  security_groups = [aws_security_group.ecs_sg.id]
  internal = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
    tags = {
    Environment = "flaskapp-alb"
  }
}
resource "aws_lb_target_group" "hello_world" {
  name        = var.tg_name
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_default_vpc.default.id
  target_type = "ip"
  stickiness {
    enabled = true
    type    = "lb_cookie"
  }
   health_check {
    path = "/"
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200,302" 
  }
}
resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.hello_world.arn
    type             = "forward"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "flaskapp-ecs-tasks-security-group"
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
