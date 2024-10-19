resource "aws_dynamodb_table" "this" {
  name           = "${var.environment}-${var.service_name}-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "S"
  }

  tags = {
    Service     = var.service_name
    Environment = var.environment
  }
}