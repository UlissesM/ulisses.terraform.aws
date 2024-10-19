resource "aws_security_group" "ecs_tasks" {
  name        = "${var.service_name}-ecs-tasks-sg"
  description = "Allow inbound access from the vpc only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    cidr_blocks     = var.allowed_cidr_blocks
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-ecs-tasks-sg"
  }
}