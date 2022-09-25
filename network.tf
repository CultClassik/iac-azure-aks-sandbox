
# 172.16.14.0	172.16.14.1 - 172.16.14.62	172.16.14.63
# 172.16.14.64	172.16.14.65 - 172.16.14.126	172.16.14.127
# 172.16.14.128	172.16.14.129 - 172.16.14.190	172.16.14.191
# 172.16.14.192	172.16.14.193 - 172.16.14.254	172.16.14.255


resource "azurerm_virtual_network" "aks" {
  name                = "vnet-terratest-${var.unique_id}"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["172.16.14.0/24"]
  tags                = local.tags_all
  depends_on = [
    azurerm_resource_group.aks
  ]
}

resource "azurerm_subnet" "aks_system_np" {
  name                 = "subnet-aks-np-system-${var.unique_id}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["172.16.14.0/26"]
  depends_on = [
    azurerm_virtual_network.aks
  ]
}

resource "azurerm_subnet" "aks_worker_np" {
  name                 = "subnet-aks-np-worker-${var.unique_id}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["172.16.14.64/26"]
  depends_on = [
    azurerm_virtual_network.aks
  ]
}