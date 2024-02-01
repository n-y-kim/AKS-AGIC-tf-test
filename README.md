# AKS-AGIC-tf-test

## Terraform flow

1. Create `agic-test-rg` resource group, virtual network and subents(node, pod, agic)
2. Create application gateway and public IP
3. Create AKS cluster with AGIC id.

## Prerequisites

- Service principal with `Contributor` role for the subscription for the AKS cluster.
  - Retrieve `client_id` and `client_secret` and add them to `variables.tf` file.

## After terraform apply

### Deploy sample app and ingress

```bash
kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/aspnetapp.yaml
```

Will be able to access the app via the public IP of the application gateway.