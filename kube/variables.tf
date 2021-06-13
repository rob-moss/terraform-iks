
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
  default     = ""
  description = "Global Variables Workspace Name.  The default value will be set to {var.cluster_name}_global_vars by the tfe variable module."
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
