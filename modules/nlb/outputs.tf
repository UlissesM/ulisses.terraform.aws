output "nlb_id" {
  value       = aws_lb.this.id
}

output "nlb_arn" {
  value       = aws_lb.this.arn
}

output "nlb_dns_name" {
  value       = aws_lb.this.dns_name
}

output "vpc_link_id" {
  value       = aws_api_gateway_vpc_link.this.id
}

output "vpc_link_arn" {
  value       = aws_api_gateway_vpc_link.this.arn
}