variable resource_group_name {}
variable location {}
variable environment {}
variable area1_billing_code_tag {}
variable area2_billing_code_tag {}
variable timestamp {}

locals {
  area1_common_tags = {
    BillingCode = var.area1_billing_code_tag
    Environment = var.environment
  }
  area2_common_tags = {
    BillingCode = var.area2_billing_code_tag
    Environment = var.environment
  }

  resource_group_name = "${var.resource_group_name}-${var.environment}-${var.timestamp}"
}