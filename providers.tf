provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-cst-api-app"
    storage_account_name = "tfstatestoragecst"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}