# Declares the main provider
provider "azurerm" {
  version = "~> 2.5.0"

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

terraform {
  backend "azurerm" {}
}

# Common module
module "common" {
  resource_group_name    = var.resource_group_name
  location               = var.location
  environment            = var.environment
  area1_billing_code_tag = var.area1_billing_code_tag
  area2_billing_code_tag = var.area2_billing_code_tag
  timestamp              = var.timestamp

  source = "./modules/common"
}

# AKS module
module "aks" {
  location    = var.location
  environment = var.environment

  # Output module common
  resource_group_name = module.common.resource_group_name
  area1_common_tags   = module.common.area1_common_tags
  area2_common_tags   = module.common.area2_common_tags

  acr_reader_user_client_id  = var.acr_reader_user_client_id
  acr_reader_user_secret_key = var.acr_reader_user_secret_key

  source     = "./modules/aks"
  depends_on = [module.common]
}