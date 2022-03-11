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

resource "dcnm_vrf" "vrf_lite" {
  fabric_name             = var.fabric
  name                    = var.vrf_lite.name
  description             = "VRF-Lite created by Terraform"
  intf_description        = "${var.vrf_lite.name}_Terraform_VRF-Lite"
  vlan_id                 = var.vrf_lite.vrf_vlan
  deploy                  = true
  attachments {
    serial_number = data.dcnm_inventory.devnet["leaf3"].serial_number
    attach        = true
    vrf_lite {
      peer_vrf_name = var.vrf_lite.name
      interface_name = var.vrf_lite.attachment_interface
    }
  }
}