# iac-azure-aks-sandbox

## This Terraform code will:
* Create an AKS cluster
* Create a user-assigned MSI for the cluster with necessary rights
* Create a kubelet with appropriate rights (manage dns sub-zone, used by externa-dns)
* Create a DNS subzone for AKS to use
* Generate a admin kubeconfig file in the parent directory
* Create an automation account and necessary resources to shut the cluster down nightly for money savings (needs work, possibly replace timestamp with a time provider resource, goal is to obtain a timestamp of a specific time, like 11:30 PM of TODAY)
* Bootstrap the cluster with secrets required for ArgoCD apps

[State is stored in Terraform Cloud.](backend.tf)

## Provisioning with Terraform
* Important files created in secret folder, check it.
* 
    ```bash
    terraform plan

    terraform apply -auto-approve

    # bootstrap cluster for argocd apps
    cp kubernetes.tf.hold kubernetes.tf &&\
    terraform apply -auto-approve

    # bootstrap the cluster for azure workload identity, managed by ArgoCO
    source secret/env &&\
    cp azwi.tf.hold azwi.tf &&\
    terraform apply -auto-approve \
        -var "oidc_k8s_issuer_url=$(az aks show -n "$CLUSTER_NAME" -g "$RG_NAME" --query "oidcIssuerProfile.issuerUrl" -otsv)"
    
    ```