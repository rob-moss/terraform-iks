
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
variable "ws_iks_cluster" {
  default     = "iks_cluster"
  description = "Intersight Kubernetes Service (IKS) Cluster Workspace Name"
  type        = string
}
