# AKS-AGIC-tf-test

## Architecture

- Resource group with virtual network and subnets(node, pod, agic)
- Application Gateway Standard V2 with private ip only
- AKS cluster using Azure CNI v2 with Managed Identity(System Assigned)
- Application Gateway Ingress Controller(AGIC) with RBAC settings to access AKS cluster.

## Terraform flow

1. Create `agic-test-rg` resource group, virtual network and subents(node, pod, agic)
2. Create application gateway.
3. Create AKS cluster with AGIC id.
4. Add RBAC for AGIC to access AKS cluster.

## Prerequisites

- Service principal with `Contributor` role for the subscription for the AKS cluster.
  - Retrieve `client_id` and `client_secret` and add them to `variables.tf` file.
- Follow [this](https://learn.microsoft.com/en-us/azure/application-gateway/application-gateway-private-deployment?tabs=portal) documentation to enable private ip only preview for Application Gateway Standard V2. This settings must be done before `terraform apply`.

## After terraform apply

### Deploy sample app and ingress

```bash
kubectl apply -f test-app.yaml
```

Since we only have private ip, access the application gateway from the AKS cluster's pod.

```bash
kubectl run test-pod --image=nginx
kubectl exec -it test-pod -- /bin/bash
curl -I http://<app-gateway-ip>
```