
#__________________________________________________________
#
# Terraform Cloud Organization
#__________________________________________________________

variable "tfc_organization" {
  default     = "CiscoDevNet"
  description = "Terraform Cloud Organization."
  type        = string
}

#______________________________________________
#
# Terraform Cloud global_vars Workspace
#______________________________________________

variable "ws_global_vars" {
  default     = "global_vars"
  description = "Global Variables Workspace Name."
  type        = string
}


#__________________________________________________________
#
# Intersight Provider Variables
#__________________________________________________________

variable "api_key" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "secret_key" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
