provider "azurerm" {
  version = "=1.7.4"
  features = {}
}

resource "azurerm_resource_group" "rg" {
  name     = "vk111"
  location = "us-east"
}

resource "azurerm_container_registry" "acr" {
  name                     = "vijay"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  admin_enabled            = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "vkclu"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "vijay.eastus.azurecontainer.io"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id     = "3f34372a-98f4-4dad-a988-3a3277055b59"
    client_secret = "25u8Q~yZapQYBBXopy-g5YQ6ymtOqM1x4oRtTcL."
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }
  }
}