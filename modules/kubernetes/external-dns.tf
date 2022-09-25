resource "kubernetes_manifest" "external_dns_secret" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "metadata" = {
      "name"      = "azure-config-file"
      "namespace" = "external-dns"
    }
    "data" = {
      "azure.json" = base64encode(var.external_dns_config)
    }
  }
  depends_on = [kubernetes_manifest.external_dns_ns]
}

resource "kubernetes_manifest" "external_dns_ns" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "external-dns"
    }
  }
}