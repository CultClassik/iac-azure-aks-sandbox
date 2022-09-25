locals {

  # msi_obj_id = "fdd3f20b-18e3-4c89-a6e9-c4ddc2265616"

  automation_start_time = timeadd(timestamp(), "20m")

  tags = merge(
    {
      unique_id = var.unique_id
    },
    var.tags
  )

  tags_all = merge(
    local.tags,
    var.tags_extra
  )

  external_dns_config = {
    tenantId        = var.arm_tenant_id,
    subscriptionId  = var.arm_subscription_id,
    resourceGroup   = azurerm_resource_group.aks_dns.name,
    useManagedIdentityExtension= true
  }

}
