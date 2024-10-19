resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

}

resource "aws_cloudwatch_log_group" "container_insights" {
  count = var.enable_container_insights ? 1 : 0
  name  = "/aws/ecs/containerinsights/${aws_ecs_cluster.this.name}/performance"

  retention_in_days = var.log_retention_days

  tags = {
    Name = "/aws/ecs/containerinsights/${aws_ecs_cluster.this.name}/performance"
  }
}


resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = var.fargate_spot_base
    weight            = var.fargate_spot_weight
    capacity_provider = "FARGATE_SPOT"
  }
}