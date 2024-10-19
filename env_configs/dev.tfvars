# General
region      = "us-east-1"
environment = "dev"

# VPC Configuration
vpc_cidr = "10.0.0.0/22" #1024 IP(s)

# Subnet Configuration
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]


# ECS Services
services = {
  users = {
    name               = "users-service"
    container_name     = "users-service"
    image              = "ulsmaia/sample-api:latest"
    cpu                = 256
    memory             = 512
    desired_count      = 2
    container_port     = 5000
    service_port       = 5000
    health_check_path  = "/health"
    environment_variables = {
      PORT = "5000"
      SERVICE_NAME = "users-service"
    }
    dynamodb_hash_key = "user_id"
    dynamodb_range_key = "email"
  },
  products = {
    name               = "products-service"
    container_name     = "products-service"
    image              = "ulsmaia/sample-api:latest"
    cpu                = 256
    memory             = 512
    desired_count      = 2
    container_port     = 3000
    service_port       = 3000
    health_check_path  = "/health"
    environment_variables = {
      PORT = "3000"
      SERVICE_NAME = "products-service"
    }
    dynamodb_hash_key = "product_id"
    dynamodb_range_key = "category"
  }
}