variable "region" {
  type = string
}

variable "environment" {
  description = "The environment (dev, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "The environment value must be either 'dev', 'prod', or 'staging'."
  }
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  description = "The availability zones to use for subnets (AZ(s))"
  type        = list(string)
}

variable "services" {
  description = "Configuration for ECS services"
  type = map(object({
    name                  = string
    container_name        = string
    image                 = string
    cpu                   = number
    memory                = number
    desired_count         = number
    container_port        = number
    service_port          = number
    health_check_path     = string
    environment_variables = map(string)
    dynamodb_hash_key     = string
    dynamodb_range_key    = string
  }))
}