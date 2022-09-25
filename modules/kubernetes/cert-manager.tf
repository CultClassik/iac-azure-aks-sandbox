resource "kubernetes_manifest" "cert_manager_secret" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "metadata" = {
      "name"      = "azuredns-config"
      "namespace" = "cert-manager"
    }
    "data" = {
      "client-secret" = base64encode(var.arm_client_secret)
    }
  }
  depends_on = [kubernetes_manifest.cert_manager_ns]
}

resource "kubernetes_manifest" "cert_manager_ns" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = "cert-manager"
    }
  }
}