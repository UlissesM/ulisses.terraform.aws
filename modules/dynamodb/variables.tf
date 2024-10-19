variable "environment" {
  type        = string
}

variable "service_name" {
  description = "The name of the service this DynamoDB table is for"
  type        = string
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
}
