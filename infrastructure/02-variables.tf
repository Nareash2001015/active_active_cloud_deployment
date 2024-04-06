
variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "deployment_name" {
  type        = string
  description = "which customer deployment"
}

variable "public_ssh_key_path" {
  type        = string
  description = "aks ssh key path"
}