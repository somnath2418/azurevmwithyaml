locals {
  config = yamldecode(file("${path.root}/config/${var.environment}.yaml"))
  tags   = yamldecode(file("${path.root}/config/tags.yaml")).tags
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${local.config.environment}-rg"
  location = local.config.location
  tags     = local.tags
}

# NETWORK MODULE
module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.config.location
  address_space       = local.config.address_space
  subnet_prefix       = local.config.subnet_prefix
  environment         = local.config.environment
  tags                = local.tags
}

# COMPUTE MODULE
module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.config.location
  subnet_id           = module.network.subnet_id
  vm_size             = local.config.vm_size
  vm_name             = local.config.vm_name
  environment         = local.config.environment
  tags                = local.tags
   admin_password = var.admin_password
}