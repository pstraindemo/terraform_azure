# configure the azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}


module "resource_group" {
    source = "./modules/resource_group"
    name = "example-resources"
    location = "North Europe"
}

module "virtual_network" {
    source = "./modules/virtual_network"
    name = "example-vnet"
    address_space = ["10.0.0.0/16"]
    location = module.resource_group.resource_group_location
    resource_group_name = module.resource_group.resource_group_name
}

module "subnet" {
    source = "./modules/subnet"
    name = "example-subnet"
    resource_group_name = module.resource_group.resource_group_name
    virtual_network_name = module.virtual_network.virtual_network_name
    address_prefixes = ["10.0.1.0/24"]
}

module virtual_machine {
    source = "./modules/virtual_machine"
    nic_name = "example-nic"
    public_ip_name = "example-public-ip"
    vm_name = "example-vm"
    location = module.resource_group.resource_group_location
    resource_group_name = module.resource_group.resource_group_name
    subnet_id = module.subnet.subnet_id
    vm_size = "Standard_B1s"
    admin_username = "<user_name>"
    admin_password = "<password>"
}