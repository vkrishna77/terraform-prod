
provider "azurerm" {
    features {}
}


module "vm" {
    source = "./module_vm"
    rg_new_name = "tfrg_new_1"
}

//variable "rg_name" {
//}
//variable "rg_location" {
 //   default = "westus"
//}

resource "azurerm_virtual_network" "vnet1" {
    name = "vnet_tf1"
    location = module.vm.rg_location
    resource_group_name = module.vm.rg_name
    address_space = ["10.0.0.0/24"]
    
}