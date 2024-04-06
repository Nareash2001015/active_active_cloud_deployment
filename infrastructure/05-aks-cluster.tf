resource "azurerm_kubernetes_cluster" "aks_cluster" {
  dns_prefix          = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.resource_group.name}-node"


  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_D8ds_v5"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }

  # Identity (System Assigned or Service Principal)
  identity { type = "SystemAssigned" }


  # Linux Profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }

  # Network Profile
  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "azure"
  }

}