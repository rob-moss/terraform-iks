#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

variable "agent_pool" {
  description = "Terraform Cloud Agent Pool."
  type        = string
}

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

variable "terraform_version" {
  default     = "1.0.0"
  description = "Terraform Target Version."
  type        = string
}

variable "vcs_repo" {
  description = "Version Control System Repository."
  type        = string
}


#__________________________________________________________
#
# Intersight Variables
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


#__________________________________________________________
#
# Global Variables Workspace
#__________________________________________________________

variable "ws_global_vars" {
  default     = "global_vars"
  description = "Global Variables Workspace Name"
  type        = string
}

#__________________________________________________________
#
# IKS kube_config Workspace
#__________________________________________________________

variable "ws_kube" {
  default     = "kube"
  description = "Intersight Kubernetes Service kube_config Workspace Name"
  type        = string
}
