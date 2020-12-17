variable "rgName" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type = map
}
variable "vnetName"{
    type = string
}
variable "nsgName"{
    type = string
}
variable "vnetCIDR" {
  type = string
}
variable "azureSubnetCIDR"{
  type = string
}
resource "azurerm_resource_group" "resourceGroup" {
  location = var.location
  name = var.rgName
  tags = var.tags
}
resource "azurerm_virtual_network" "azureVnet" {
  name                = var.vnetName
  resource_group_name = azurerm_resource_group.resourceGroup.name
  location            = azurerm_resource_group.resourceGroup.location
  address_space       = [var.vnetCIDR]
  tags = var.tags
}
resource "azurerm_network_security_group" "sitetositensg" {
  name                = var.nsgName
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name
  tags = var.tags
}
resource "azurerm_network_security_rule" "rule22" {
    direction = "Inbound"
    source_address_prefix = "0.0.0.0/0"
    network_security_group_name = var.nsgName
    access = "Deny"
    priority = 100
    destination_address_prefix = "*"
    destination_port_range     = "22"
    protocol                   = "TCP"
}
resource "azurerm_network_security_rule" "rule3389" {
    direction = "Inbound"
    source_address_prefix = "0.0.0.0/0"
    network_security_group_name = var.nsgName
    access = "Deny"
    priority = 100
    destination_address_prefix = "*"
    destination_port_range     = "3389"
    protocol                   = "TCP"
}
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.resourceGroup.name
  virtual_network_name = azurerm_virtual_network.azureVnet.name
  address_prefix       = var.azureSubnetCIDR
  depends_on           = [azurerm_virtual_network.azureVnet]
}
