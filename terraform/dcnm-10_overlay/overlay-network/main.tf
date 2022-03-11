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

resource "dcnm_network" "overlay_network" {
  fabric_name     = var.fabric
  name            = var.overlay_network.network_name
  network_id      = 30001
  description     = "${var.overlay_network.network_name}_Terraform"
  vrf_name        = var.vrf_name
  vlan_id         = var.overlay_network.vlan_id
  vlan_name       = var.overlay_network.vlan_name
  ipv4_gateway    = var.overlay_network.ipv4_gateway
  ir_enable_flag  = true
  deploy = true
  attachments {
    serial_number = data.dcnm_inventory.devnet["leaf1"].serial_number
    vlan_id       = var.overlay_network.vlan_id
    attach        = true
    switch_ports = ["Ethernet1/11"]
  }
  attachments {
    serial_number = data.dcnm_inventory.devnet["leaf2"].serial_number
    vlan_id       = var.overlay_network.vlan_id
    attach        = true
    switch_ports = ["Ethernet1/11"]
  }
}