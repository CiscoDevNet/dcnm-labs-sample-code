terraform {
  required_providers {
    dcnm = {
      source = "CiscoDevNet/dcnm"
    }
  }
}

provider "dcnm" {
  # Cisco DCNM/NDFC user name
  username = var.user.username
  # Cisco DCNM/NDFC password
  password = var.user.password
  # Cisco DCNM/NDFC url
  url      = var.user.url
  insecure = true
  # Used to select DCNM or NDFC for authentication purposes
  platform = "dcnm"
}

#resource "dcnm_rest" "config-sync" {
#  path    = "/rest/control/fabrics/${var.fabric}/config-deploy/"
#  method = "POST"
#  payload = "{}"
#}

data "dcnm_inventory" "new-switch" {
  fabric_name = var.fabric
  switch_name = var.leaf4.name
}

resource "dcnm_rest" "config-sync" {
  path    = "/rest/control/fabrics/${var.fabric}/config-deploy/${data.dcnm_inventory.new-switch.serial_number}"
  method = "POST"
  payload = "{}"
}