terraform {
  backend "remote" {
    organization = "Diehlabs"

    workspaces {
      name = "iac-azure-aks-sandbox"
    }
  }
}