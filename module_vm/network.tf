provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = "myRG_from_TF"
    location = "eastus"
}

resource "azurerm_network_security_group" "nsg"{
    name = "nsg_tf"
    location = "eastus"
    resource_group_name = azurerm_resource_group.rg.name
    
}

resource "azurerm_virtual_network" "vnet" {
    name = "vnet_tf"
    location = "eastus"
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["192.168.0.0/16"]
    
}

resource "azurerm_subnet" "snet" {
    name = "subnet_tf"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "snet1" {
    name = "subnet_tf1"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["192.168.2.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "name" {
    subnet_id = azurerm_subnet.snet.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "name1" {
    subnet_id = azurerm_subnet.snet1.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

output "rg_name" {
    value = azurerm_resource_group.rg.name
}

output "rg_location" {
    value = azurerm_resource_group.rg.location
}
