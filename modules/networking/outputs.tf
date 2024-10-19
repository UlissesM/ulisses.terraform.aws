output "vpc_id" {
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.main.id
}


