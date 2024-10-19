output "api_gateway_urls" {
  description = "URLs of all API Gateways"
  value = {
    for service, api_gateway in module.api_gateways : service => {
      invoke_url = api_gateway.api_invoke_url
      stage      = api_gateway.api_stage_name
    }
  }
}

output "api_gateway_endpoints" {
  description = "Endpoints for each service in each API Gateway"
  value = {
    for service, api_gateway in module.api_gateways : service => {
      health_endpoint = "${api_gateway.api_invoke_url}/health"
      test_endpoint   = "${api_gateway.api_invoke_url}/test"
    }
  }
}

output "dynamodb_table_names" {
  description = "Names of all DynamoDB tables"
  value = {
    for service, dynamodb in module.dynamodb_tables : service =>  dynamodb.table_name
  }
}

output "ecs_service_names" {
  description = "Names of all ECS services"
  value = {
    for service, ecs_service in module.ecs_services : service => ecs_service.service_name
  }
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = module.nlb.nlb_dns_name
}