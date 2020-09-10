# Creates the main AKS
resource "azurerm_kubernetes_cluster" "AKS" {
  name                = "aks-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.environment}"

  default_node_pool {
    name                = "area1"
    vm_size             = "Standard_D1_v2"
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
    max_count           = lookup(var.auto_scaling_max_count, var.environment)
    min_count           = lookup(var.auto_scaling_min_count, var.environment)
    node_count          = lookup(var.auto_scaling_default_node_count, var.environment)
    node_labels         = { app : "area1" }

    tags = var.area1_common_tags
  }

  network_profile {
    network_plugin = "azure"
  }

  node_resource_group = "${var.resource_group_name}-nodes"

  service_principal {
    client_id     = var.acr_reader_user_client_id
    client_secret = var.acr_reader_user_secret_key
  }

  tags = var.area2_common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "platform_nodes" {
  name                  = "area2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.AKS.id
  vm_size               = "Standard_D1_v2"
  enable_auto_scaling   = true
  max_count             = lookup(var.auto_scaling_max_count, var.environment)
  min_count             = lookup(var.auto_scaling_min_count, var.environment)
  node_count            = lookup(var.auto_scaling_default_node_count, var.environment)
  node_labels           = { app : "area2" }

  tags = var.area2_common_tags
}