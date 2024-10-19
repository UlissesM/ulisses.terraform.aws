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
    name              = "users-service"
    container_name    = "users-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 5000
    service_port      = 5000
    health_check_path = "/health"
    environment_variables = {
      PORT         = "5000"
      SERVICE_NAME = "users-service"
    }
    dynamodb_hash_key  = "user_id"
    dynamodb_range_key = "email"
  },
  products = {
    name              = "products-service"
    container_name    = "products-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 3000
    service_port      = 3000
    health_check_path = "/health"
    environment_variables = {
      PORT         = "3000"
      SERVICE_NAME = "products-service"
    }
    dynamodb_hash_key  = "product_id"
    dynamodb_range_key = "category"
  },
  orders = {
    name              = "orders-service"
    container_name    = "orders-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 5050
    service_port      = 5050
    health_check_path = "/health"
    environment_variables = {
      PORT         = "5050"
      SERVICE_NAME = "orders-service"
    }
    dynamodb_hash_key  = "order_id"
    dynamodb_range_key = "user_id"
  },
  inventory = {
    name              = "inventory-service"
    container_name    = "inventory-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 5010
    service_port      = 5010
    health_check_path = "/health"
    environment_variables = {
      PORT         = "5010"
      SERVICE_NAME = "inventory-service"
    }
    dynamodb_hash_key  = "product_id"
    dynamodb_range_key = "product_type"
  },
  payments = {
    name              = "payments-service"
    container_name    = "payments-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 5005
    service_port      = 5005
    health_check_path = "/health"
    environment_variables = {
      PORT         = "5005"
      SERVICE_NAME = "payments-service"
    }
    dynamodb_hash_key  = "payment_id"
    dynamodb_range_key = "order_id"
  },
}