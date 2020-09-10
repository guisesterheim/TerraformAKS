output aks_name {
  value = module.aks.aks_name
}

output resource_group_name {
  value = module.common.resource_group_name
}

# Retrieves the fully qualified domain name
output aks_fqdn {
  value = module.aks.aks_fqdn
}