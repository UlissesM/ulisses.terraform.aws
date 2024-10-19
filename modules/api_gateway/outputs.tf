output "api_id" {
  value       = aws_api_gateway_rest_api.this.id
}

output "api_stage_name" {
  description = "The name of the API Gateway stage"
  value       = aws_api_gateway_deployment.this.stage_name
}

output "api_invoke_url" {
  description = "The URL to invoke the API Gateway"
  value       = aws_api_gateway_deployment.this.invoke_url
}

output "api_name" {
  description = "The name of the API Gateway"
  value       = aws_api_gateway_rest_api.this.name
}

output "api_key" {
  value       = aws_api_gateway_api_key.this.value
  sensitive   = true
}