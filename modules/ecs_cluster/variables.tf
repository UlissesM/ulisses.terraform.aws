variable "cluster_name" {
  type        = string
}

variable "enable_container_insights" {
  type        = bool
  default     = true
}

variable "fargate_spot_base" {
  type        = number
  default     = 1
}

variable "fargate_spot_weight" {
  type        = number
  default     = 100
}
