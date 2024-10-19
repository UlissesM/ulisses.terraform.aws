output "service_name" {
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.this.arn
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
}

output "security_group_id" {
  value       = aws_security_group.ecs_tasks.id
}

output "execution_role_arn" {
  value       = aws_iam_role.ecs_execution_role.arn
}

output "task_role_arn" {
  value       = aws_iam_role.ecs_task_role.arn
}