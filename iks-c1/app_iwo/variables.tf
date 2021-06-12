#----------------------------------
# Terraform Cloud Organization
#----------------------------------
variable "tfc_organization" {
  default     = "DevNet"
  description = "Terraform Cloud Organization."
  type        = string
}


#----------------------------------
# Terraform Cloud Workspaces
#----------------------------------
variable "ws_global_vars" {
  default     = "global_vars"
  description = "Global Variables Workspace Name."
  type        = string
}

variable "ws_iks_cluster" {
  default     = "iks_cluster"
  description = "Intersight Kubernetes Service (IKS) Cluster Workspace Name"
  type        = string
}
