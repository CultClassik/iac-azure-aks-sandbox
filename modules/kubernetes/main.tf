provider "kubernetes" {
  host                   = "https://${var.k8s_creds.host}:443"
  client_certificate     = var.k8s_creds.client_cert
  client_key             = var.k8s_creds.client_key
  cluster_ca_certificate = var.k8s_creds.cluster_ca_cert
}
