output aks_name {
  value = azurerm_kubernetes_cluster.AKS.name
}

output aks_fqdn {
  value = azurerm_kubernetes_cluster.AKS.fqdn
}