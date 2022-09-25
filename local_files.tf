# resource "local_file" "ssh_private_key" {
#   content         = tls_private_key.aks.private_key_pem
#   filename        = "adminuser_rsa.key"
#   file_permission = "0600"
# }

resource "local_file" "kubeconfig" {
  content         = module.aks_cluster.kube_admin_config
  filename        = "./secret/kubeconfig"
  file_permission = "0600"
  depends_on = [
    module.aks_cluster
  ]
}

resource "local_file" "external_dns_config" {
  content = jsonencode({
    tenantId                    = data.azurerm_client_config.current.tenant_id
    subscriptionId              = data.azurerm_client_config.current.subscription_id
    resourceGroup               = azurerm_resource_group.aks_dns.name
    useManagedIdentityExtension = true
  })
  filename        = "./secret/azure.json"
  file_permission = "0600"
  depends_on = [
    module.aks_cluster
  ]
}

resource "local_file" "env_vars" {
  content         = <<EOT
RG_NAME="${azurerm_resource_group.aks.name}"
DNS_RG_NAME="${azurerm_resource_group.aks_dns.name}"
DNS_ZONE_NAME="${azurerm_dns_zone.aks_dns.name}"
CLUSTER_FQDN="${module.aks_cluster.cluster_fqdn}"
CLUSTER_NAME="${module.aks_cluster.cluster_name}"
MSI_ID="${azurerm_user_assigned_identity.aks_nodepool.client_id}"
EOT
  filename        = "./secret/env"
  file_permission = "0600"
  depends_on = [
    module.aks_cluster
  ]
}