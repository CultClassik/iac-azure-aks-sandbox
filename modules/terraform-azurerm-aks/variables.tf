variable "tags" {
  description = "Tag information to be assigned to resources created."
  type = object({
    product     = string
    unique_id   = string
    environment = string
    location    = string
    owner       = string
  })
}

variable "tags_extra" {
  description = "Optional extra tag information to be assigned to resources created."
  type        = map(any)
  default     = {}
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create the cluster in"
}

variable "location" {
  description = "The location for creating resources"
  type        = string
}

# variable "product" {
#   description = "The name of the product."
#   type = string
#   # validation {
#   #   condition     = var.tags.product [a-z][0-9][-]
#   #   error_message = "Must use numbers, letters and dashes."
#   # }
# }

variable "resource_group" {
  description = <<EOD
  (Optional) the resource group object to create resources in.
  One will be created if none is provided.
EOD
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = null
    location = null
  }
}

# variable "laws" {
#   description = "The log analytics workspace to be used for the AKS cluster."
#   type = object({
#     id       = string
#     name     = string
#     location = string
#   })
# }

variable "node_count_system" {
  description = "Number of nodes in system node pool"
  type        = string
}

variable "node_count_worker" {
  description = "Number of nodes in worker node pool"
  type        = string
}

variable "kubernetes_version_number" {
  description = "Kubernetes cluster version number"
  type        = string
}

variable "subnet_id_system_np" {
  description = "ID for the subnet the system nodepool will use"
  type        = string
}

variable "subnet_id_worker_np" {
  description = "ID for the subnet the worker nodepool will use"
  type        = string
}

variable "vm_size_system" {
  type        = string
  description = "VM size for AKS system nodes"
}

variable "vm_size_worker" {
  type        = string
  description = "VM size for AKS worker nodes"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size for AKS cluster nodes"
  default     = 30
}

variable "node_pool_type" {
  type        = string
  description = "The node pool type for the AKS cluster"
  default     = "VirtualMachineScaleSets"
}

variable "linux_profile" {
  description = "User name and SSH public key for the admin account on cluster hosts."
  type = object({
    username = string,
    sshkey   = string
  })
  default = {
    username = null,
    sshkey   = null
  }
}

variable "docker_bridge_cidr" {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
}

variable "service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
}

variable "private_cluster_enabled" {
  type        = bool
  description = "This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  default     = false
}

variable "cluster_admin_ids" {
  type        = list(any)
  description = "A list of Azure AD ObjectIDs that will receive admin rights to the cluster."
}

variable "max_pods" {
  description = "Max pods per node. 1 IP address reserved per (this value x number of nodes)"
  default     = 30
}

variable "msi_ids" {
  description = "List of optional MSI IDs to assign to the cluster"
  type        = list(string)
  default     = []
}

variable "orchestrator_version" {
  description = "The version of Kubernetes to install on nodes"
  type        = string
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  default     = true
  description = "Disable local admin - this will mean the admin kubeconf will not be usable"
}

variable "kubelet_identity" {
  description = "User assigned identity for use by kubelets"
}

variable "cluster_identity" {
  description = "User assigned identity for use by AKS"
}