variable "service_name" {
  type        = string
}

variable "cluster_id" {
  type        = string
}

variable "task_cpu" {
  type        = number
}

variable "task_memory" {
  type        = number
}

variable "container_name" {
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "service_port" {
  description = "Port on which the service will receive traffic"
  type        = number
}

variable "desired_count" {
  type        = number
}

variable "subnet_ids" {
  type        = list(string)
}

variable "vpc_id" {
  type        = string
}

variable "nlb_arn" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the ECS tasks"
  type        = list(string)
}

variable "health_check_path" {
  description = "Path for the health check"
  type        = string
  default     = "/health"
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the container"
  type        = map(string)
  default     = {}
}

variable "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table for this service"
  type        = string
}