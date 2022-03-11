variable "user" {
  description = "Login information for DCNM/NDFC"
  type        = map
  default     = {
    username = "admin"
    password = "Cisco1234!"
    url      = "https://10.10.20.18"
  }
}

variable "overlay_network" {
  description = "Overlay network information"
  type = map
  default     = {
    network_name = "DevNet_Network"
    vlan_id = 2500
    vlan_name = "Overlay_VLAN"
    ipv4_gateway = "9.9.9.9/24"
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

variable "vrf_lite" {
  description = "VRF-Lite information"
  type = map
  default = {
    name = "DevNet_VRF_Lite"
    vrf_vlan = 2133
    attachment_interface = "GigabitEthernet2"
    dot1q_tag = 33
    ipv4_address = "10.33.0.2/30"
    neighbor_ipv4_address = "10.33.0.1"
  }
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
