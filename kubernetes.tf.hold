module "kubernetes" {
  source = "./modules/kubernetes"
  k8s_creds = {
    host            = module.aks_cluster.cluster_fqdn
    client_cert     = base64decode(module.aks_cluster.kube_admin_client_certificate)
    client_key      = base64decode(module.aks_cluster.kube_admin_client_key)
    cluster_ca_cert = base64decode(module.aks_cluster.kube_admin_cluster_ca_certificate)
  }
  arm_client_secret   = var.arm_client_secret
  external_dns_config = jsonencode(local.external_dns_config)
}
