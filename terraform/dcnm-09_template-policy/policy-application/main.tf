#configure provider with your Cisco DCNM/NDFC credentials.
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
  fabric_name = "DevNet_Fabric"
  for_each    = var.fabric_inventory
  switch_name = each.value.name
}

resource "dcnm_policy" "syslog" {
  for_each = data.dcnm_inventory.devnet
  serial_number = each.value.serial_number
  template_name = "tf-syslog"
  template_props = {
    "SYSLOG_IP" : "5.5.5.5"
  }
  priority    = 500
  description = "Syslog policy via TF"
}

output "spine1_serial" {
  value = data.dcnm_inventory.devnet["spine1"].serial_number
}
output "spine2_serial" {
  value = data.dcnm_inventory.devnet["spine2"].serial_number
}
output "leaf1_serial" {
  value = data.dcnm_inventory.devnet["leaf1"].serial_number
}
output "leaf2_serial" {
  value = data.dcnm_inventory.devnet["leaf2"].serial_number
}
output "leaf3_serial" {
  value = data.dcnm_inventory.devnet["leaf3"].serial_number
}