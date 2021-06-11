#---------------------------
# Terraform Cloud Variables
#---------------------------
variable "terraform_cloud_token" {
  description = "Token to Authenticate to the Terraform Cloud."
  sensitive   = true
  type        = string
}

variable "tfc_oath_token" {
  description = "Terraform Cloud OAuth Token for VCS_Repo Integration."
  sensitive   = true
  type        = string
}

variable "tfc_organization" {
  description = "Terraform Cloud Organization Name."
  type        = string
}

variable "agent_pool" {
  description = "Terraform Cloud Agent Pool."
  type        = string
}

variable "vcs_repo" {
  description = "Terraform Cloud Organization Name."
  type        = string
}


#---------------------------
# Intersight Variables
#---------------------------
variable "organization" {
  default     = "default"
  description = "Intersight Organization Name."
  type        = string
}

variable "api_key" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "secret_key" {
  description = "Intersight Secret Key or file location."
  sensitive   = true
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

