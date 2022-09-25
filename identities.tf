# -----------------------------------------------------------------------------
# cluster msi
# -----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "aks_cluster" {
  resource_group_name = azurerm_resource_group.aks.name
  location            = var.tags.location
  name                = "msi-aks-cluster"
  tags                = local.tags_all
}

resource "azurerm_role_assignment" "aks_cluster_contrib" {
  scope                = azurerm_resource_group.aks.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_cluster.principal_id
}

resource "azurerm_role_assignment" "aks_cluster_msiop" {
  scope                = azurerm_user_assigned_identity.aks_nodepool.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azurerm_user_assigned_identity.aks_cluster.principal_id
}

# -----------------------------------------------------------------------------
# nodepool msi
# -----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "aks_nodepool" {
  resource_group_name = azurerm_resource_group.aks.name
  location            = var.tags.location
  name                = "aks-cluster-nodepool"
  tags                = local.tags_all
}

# grant rights to k8s node msi for dns
resource "azurerm_role_assignment" "dns" {
  scope                = azurerm_resource_group.aks_dns.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_nodepool.principal_id
}

# id - The user assigned identity ID.
# principal_id - Service Principal ID associated with the user assigned identity.
# client_id - Client ID associated with the user assigned identity.
# tenant_id - Tenant ID associated with the user assigned identity.