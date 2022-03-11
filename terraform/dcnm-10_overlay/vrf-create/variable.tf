variable "user" {
  description = "Login information for DCNM/NDFC"
  type        = map
  default     = {
    username = "admin"
    password = "Cisco1234!"
    url      = "https://10.10.20.18"
  }
}

variable "fabric" {
  description = "Desired fabric for Terraform"
  type = string
  default = "DevNet_Fabric"
}

variable "vrf_name" {
  description = "VRF name"
  type = string
  default = "DevNet_VRF"
}

variable "vlan_name" {
  description = "VLAN name"
  type = string
  default = "DevNet_VLAN"
}

variable "fabric_inventory" {
  description = "Complete inventory for DevNet_Fabric"
  type        = map
  default = {
    spine1 = {
      name = "spine1"
      ip = "10.10.20.171"
      role = "spine"
    },
    spine2 = {
      name = "spine2"
      ip = "10.10.20.172"
      role = "spine"
    },
    leaf1 = {
      name = "leaf1"
      ip = "10.10.20.173"
      role = "leaf"
    },
    leaf2 = {
      name = "leaf2"
      ip = "10.10.20.174"
      role = "leaf"
    },
    leaf3 = {
      name = "leaf3"
      ip = "10.10.20.175"
      role = "leaf"
    },
  }
}
