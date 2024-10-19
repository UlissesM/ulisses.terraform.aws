provider "aws" {
  region = var.region
}

module "networking" {
  source               = "./modules/networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "nlb" {
  source      = "./modules/nlb"
  subnet_ids  = module.networking.private_subnet_ids
  environment = var.environment
}

module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = "${var.environment}-ecommerce-cluster"
}

module "dynamodb_tables" {
  source   = "./modules/dynamodb"
  for_each = var.services

  environment  = var.environment
  service_name = each.key
  hash_key     = each.value.dynamodb_hash_key
  range_key    = each.value.dynamodb_range_key
}

module "ecs_services" {
  source   = "./modules/ecs_service"
  for_each = var.services

  service_name          = each.value.name
  cluster_id            = module.ecs_cluster.cluster_id
  task_cpu              = each.value.cpu
  task_memory           = each.value.memory
  container_name        = each.value.container_name
  container_image       = each.value.image
  container_port        = each.value.container_port
  service_port          = each.value.service_port
  desired_count         = each.value.desired_count
  subnet_ids            = module.networking.private_subnet_ids
  vpc_id                = module.networking.vpc_id
  nlb_arn               = module.nlb.nlb_arn
  aws_region            = var.region
  allowed_cidr_blocks   = [module.networking.vpc_cidr_block]
  health_check_path     = each.value.health_check_path
  environment_variables = each.value.environment_variables
  dynamodb_table_arn    = module.dynamodb_tables[each.key].table_arn
}

module "api_gateways" {
  source   = "./modules/api_gateway"
  for_each = var.services

  environment  = var.environment
  service_name = each.key
  nlb_dns_name = module.nlb.nlb_dns_name
  vpc_link_id  = module.nlb.vpc_link_id
  service_port = each.value.service_port
}


