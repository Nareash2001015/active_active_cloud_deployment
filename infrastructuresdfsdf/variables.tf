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
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "environment" {
  type        = string
  description = "Migration environment"
}

variable "deployment_name" {
  type        = string
  description = "which customer deployment"
}

# variable "public_ssh_key_path" {
#   type        = string
#   description = "aks ssh key path"
# }