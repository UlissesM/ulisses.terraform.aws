resource "aws_lb_target_group" "this" {
  name        = "${var.service_name}-tg"
  port        = var.container_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    path                = var.health_check_path
    port                = "traffic-port"
    unhealthy_threshold = 3
    timeout             = 6
  }

  
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = var.nlb_arn
  port              = var.service_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}