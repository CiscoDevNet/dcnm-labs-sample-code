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

resource "dcnm_template" "tf-syslog" {
  name                  = "tf-syslog"
  content               = <<EOF
##template variables
#    Copyright (c) 2019 by Cisco Systems, Inc.
#    All rights reserved.

@(DisplayName="SYSLOG IP Address", Description="SYSLOG IP Address")
ipAddressWithoutPrefix SYSLOG_IP;
##
##template content
logging server $$SYSLOG_IP$$ 5 use-vrf management
logging source-interface mgmt0
##
EOF
  description           = "Test"
  template_type         = "POLICY"
  supported_platforms   = ["N9K"]
  template_content_type = "TEMPLATE_CLI"
  tags                  = "terraform"
}