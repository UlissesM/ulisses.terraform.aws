variable "region" {
  type        = string
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  type        = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
}

variable "private_subnet_cidrs" {
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones to use for subnets (AZ(s))"
  type        = list(string)
}