provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = "3.97.1"
  }
  backend "azurerm" {
    resource_group_name = "rg-cst-api-app"
    storage_account_name = "tfstatestoragecst"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}