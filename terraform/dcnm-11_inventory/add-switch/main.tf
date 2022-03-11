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

resource "dcnm_inventory" "leaf4" {
  fabric_name   = var.fabric
  username      = var.leaf4.username
  password      = var.leaf4.password
  max_hops      = 0
  preserve_config = "false"
  auth_protocol = 0
  config_timeout = 15

  switch_config {
    ip   = var.leaf4.ip
    role = var.leaf4.role
  }
}