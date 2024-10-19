resource "aws_lb" "this" {
  name               = "${var.environment}-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_ids
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_api_gateway_vpc_link" "this" {
  name        = "${var.environment}-vpc-link"
  description = "VPC Link for ${var.environment}"
  target_arns = [aws_lb.this.arn]
  
  tags = {
    Environment = var.environment
  }
}