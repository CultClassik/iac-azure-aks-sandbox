provider "azurerm" {
  features {}
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "aks" {
  name     = "rg-aks-cluster-${var.unique_id}"
  location = var.tags.location
  tags     = local.tags_all
}

resource "tls_private_key" "aks" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "aks_cluster" {
  source                    = "./modules/terraform-azurerm-aks"
  resource_group_name       = azurerm_resource_group.aks.name
  tags                      = local.tags
  tags_extra                = var.tags_extra
  subnet_id_system_np       = azurerm_subnet.aks_system_np.id
  subnet_id_worker_np       = azurerm_subnet.aks_worker_np.id
  docker_bridge_cidr        = "192.168.0.1/16"
  dns_service_ip            = "172.16.100.126"
  service_cidr              = "172.16.100.0/25"
  kubernetes_version_number = "1.24.0"
  location                  = var.tags.location
  max_pods                  = var.max_pods
  local_account_disabled    = false
  cluster_admin_ids         = ["9ba4a348-227d-4411-bc37-3fb81ee8bc48"]
  # msi_id            = var.msi_id #data.terraform_remote_state.devtest_infra.outputs.identity.id
  # laws                = data.azurerm_log_analytics_workspace.example
  # identities
  cluster_identity = azurerm_user_assigned_identity.aks_cluster
  kubelet_identity = azurerm_user_assigned_identity.aks_nodepool
  # nodepools
  vm_size_system    = var.vm_size_system
  node_count_system = var.node_count_system
  vm_size_worker    = var.vm_size_worker
  node_count_worker = var.node_count_worker

  depends_on = [
    azurerm_resource_group.aks,
    azurerm_subnet.aks_system_np,
    azurerm_subnet.aks_worker_np,
    azurerm_user_assigned_identity.aks_cluster,
    azurerm_user_assigned_identity.aks_nodepool,
  ]
}

# data "azuread_group" "kube_admins" {
#   display_name     = "kube_admins"
#   security_enabled = true
# }
