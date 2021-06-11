#-------------------------------
# Intersight Provider Variables
#-------------------------------
variable "api_key" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL"
  type        = string
}

variable "secret_key" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


#-------------------------
# IKS Variables Workspace
#-------------------------
variable "iks_ws_name" {
  default     = "iks"
  description = "Intersight Kubernetes Service (IKS) Workspace Name"
  type        = string
}

