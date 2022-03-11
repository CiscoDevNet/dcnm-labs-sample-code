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

data "dcnm_inventory" "devnet" {
  fabric_name = var.fabric
  for_each    = var.fabric_inventory
  switch_name = each.value.name
}

resource "dcnm_vrf" "internal_vrf" {
  fabric_name             = var.fabric
  name                    = var.vrf_name
  vlan_name               = var.vlan_name
  description             = "VRF created by Terraform"
  intf_description        = "${var.vrf_name}_Terraform"
  deploy                  = true
  attachments {
    serial_number = data.dcnm_inventory.devnet["leaf1"].serial_number
    attach        = true
  }
  attachments {
    serial_number = data.dcnm_inventory.devnet["leaf2"].serial_number
    attach        = true
  }
}