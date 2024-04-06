# Terraform Resource to Create Azure Resource Group with Input Variables defined in variables.tf
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}


