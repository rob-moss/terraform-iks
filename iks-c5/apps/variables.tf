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

variable "ws_kube" {
  default     = "kube"
  description = "Intersight Kubernetes Service (IKS) kube_config Workspace Name"
  type        = string
}
