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

variable "ws_iks_policy" {
  default     = "iks_policies"
  description = "Intersight Kubernetes Service Policies Workspace."
  type        = string
}


#-------------------------------
# Intersight Provider Variables
#-------------------------------
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


#---------------------
# IKS Cluster
#---------------------
variable "load_balancers" {
  default     = 3
  description = "Intersight Kubernetes Load Balancer count."
  type        = string
}

variable "ssh_user" {
  default     = "iksadmin"
  description = "Intersight Kubernetes Service Cluster Default User."
  type        = string
}

variable "ssh_key" {
  description = "Intersight Kubernetes Service Cluster SSH Public Key."
  sensitive   = true
  type        = string
}

variable "master_instance_type" {
  default     = "small"
  description = "K8S Master Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "master_desired_size" {
  default     = 1
  description = "K8S Master Desired Cluster Size."
  type        = string
}

variable "master_max_size" {
  default     = 1
  description = "K8S Master Maximum Cluster Size."
  type        = string
}

variable "worker_instance_type" {
  default     = "small"
  description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "worker_desired_size" {
  default     = 0
  description = "K8S Worker Desired Cluster Size."
  type        = string
}

variable "worker_max_size" {
  default     = 4
  description = "K8S Worker Maximum Cluster Size."
  type        = string
}


#------------------
# IKS Cluster Tags
#------------------
variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}
