# iac-azure-aks-sandbox

## This Terraform code will:
* Create an AKS cluster
* Create a DNS subzone for AKS to use
* Generate a admin kubeconfig file in the parent directory
* Create an automation account and necessary resources to shut the cluster down nightly for money savings (needs work, possibly replace timestamp with a time provider resource, goal is to obtain a timestamp of a specific time, like 11:30 PM of TODAY)

State is stored in Terraform Cloud.

## Provisioning with Terraform
* Important files created in secret folder, check it.
* 
    ```bash
    terraform plan

    terraform apply -auto-approve

    source secret/env &&\
    cp terraform/azwi.tf.bak terraform/azwi.tf &&\
    terraform -chdir=terraform apply -auto-approve \
        -var "oidc_k8s_issuer_url=$(az aks show -n "$CLUSTER_NAME" -g "$RG_NAME" --query "oidcIssuerProfile.issuerUrl" -otsv)"
    
    ```