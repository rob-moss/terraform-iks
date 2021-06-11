#----------------------------------
# Terraform Cloud Organization
#----------------------------------
variable "tfc_organization" {
  default     = "DevNet"
  description = "Terraform Cloud Organization."
  type        = string
}


#----------------------------
# Global Variables Workspace
#----------------------------
variable "ws_global_vars" {
  default     = "global_vars"
  description = "Global Variable Workspace Name"
  type        = string
}

