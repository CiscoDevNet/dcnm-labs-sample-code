variable "user" {
  description = "Login information for DCNM/NDFC"
  type        = map
  default     = {
    username = "admin"
    password = "Cisco1234!"
    url      = "https://10.10.20.18"
  }
}