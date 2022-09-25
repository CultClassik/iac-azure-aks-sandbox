# "Standard_B2s" = 2/4
# "Standard_B2ms" = 2/8
# "Standard_A2m_v2" = 2/16

unique_id         = "001"
node_count_system = 3
vm_size_system    = "Standard_B2ms"
max_pods          = 36
# node_count_worker = 3
# vm_size_worker    = "Standard_B2ms"

tags = {
  environment = "test"
  owner       = "Chris Diehl"
  product     = "aks-playground"
  location    = "eastus"
}

# auto_start_time = "2022-08-15T05:00:00Z"
