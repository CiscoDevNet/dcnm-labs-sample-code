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
data "dcnm_inventory" "test" {
  fabric_name = "DevNet_Fabric"
  switch_name = "spine1"
}

output "device_ip" {
  value = data.dcnm_inventory.test.ip
}