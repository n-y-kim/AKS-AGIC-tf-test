resource "azurerm_resource_group" "k8s-rg" {
    name = "agic-test-rg"
    location = var.rg-location
}

resource "azurerm_virtual_network" "k8s-vnet" {
  name                = "k8s-vnet"
  resource_group_name = azurerm_resource_group.k8s-rg.name
  location            = azurerm_resource_group.k8s-rg.location
  address_space       = ["172.0.0.0/16"]
}

resource "azurerm_subnet" "node-subnet" {
  name                 = "node-subnet"
  resource_group_name  = azurerm_resource_group.k8s-rg.name
  virtual_network_name = azurerm_virtual_network.k8s-vnet.name
  address_prefixes     = ["172.0.32.0/24"]
}

resource "azurerm_subnet" "pod-subnet" {
  name                 = "pod-subnet"
  resource_group_name  = azurerm_resource_group.k8s-rg.name
  virtual_network_name = azurerm_virtual_network.k8s-vnet.name
  address_prefixes     = ["172.0.48.0/20"]
}

resource "azurerm_subnet" "ingress-appgateway-subnet" {
    name = "ingress-appgateway-subnet"
    resource_group_name = azurerm_resource_group.k8s-rg.name
    virtual_network_name = azurerm_virtual_network.k8s-vnet.name
    address_prefixes = ["172.0.34.0/24"]
}