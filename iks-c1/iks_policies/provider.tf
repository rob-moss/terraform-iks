#---------------------------------
# Terraform Required Parameters
#---------------------------------
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.8"
    }
  }
}

#---------------------------------
# Intersight Provider Settings
#---------------------------------
provider "intersight" {
  apikey   = var.api_key
  endpoint = local.endpoint
  secretkey = var.secret_key
}
