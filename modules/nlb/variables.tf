variable "subnet_ids" {
  description = "List of subnet IDs for the NLB"
  type        = list(string)
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
}