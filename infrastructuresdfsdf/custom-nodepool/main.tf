resource "azurerm_kubernetes_cluster_node_pool" "custom-nodepool" {
  name                  = "${var.nodepool_name}"
  kubernetes_cluster_id = "${var.kubernetes_cluster_id}"
  vm_size               = "${var.vm_size}"
  node_count            = "${var.node_count}"
}