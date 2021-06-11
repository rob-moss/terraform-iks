#-----------------------------------
# Intersight Organization Variables
#-----------------------------------
variable "organization" {
  default     = "default"
  description = "Intersight Organization."
  type        = string
}
output "organization" {
  value = var.organization
}

#----------------------
# IKS Cluster Variable
#----------------------
variable "cluster_name" {
  default     = "iks"
  description = "Intersight Kubernetes Service Cluster Name."
  type        = string
}

#-----------------------------------
# DNS Variables
#-----------------------------------
variable "domain_name" {
  default     = "demo.intra"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}

variable "dns_primary" {
  description = "Primary DNS Server for Kubernetes Sysconfig Policy."
  type        = string
}

variable "dns_secondary" {
  default     = ""
  description = "Secondary DNS Server for Kubernetes Sysconfig Policy."
  type        = string
}


#-----------------------------------
# Time Variables
#-----------------------------------
variable "timezone" {
  default     = "America/New_York"
  description = "Timezone for Kubernetes Sysconfig Policy."
  type        = string
}
output "timezone" {
  value = var.timezone
}


#-----------------------------------
# IP Pool Variables
#-----------------------------------
variable "ip_pool_gateway" {
  default     = "254"
  description = "IP Pool Gateway last Octet.  The var.network_prefix will be combined with ip_pool_gateway for the Gateway Address."
  type        = string
}

variable "ip_pool_from" {
  default     = "20"
  description = "IP Pool Starting IP last Octet.  The var.network_prefix will be combined with ip_pool_from for the Gateway Address."
  type        = string
}

#--------------------------------
# K8S VM Infra Policy Variables
#--------------------------------
variable "vsphere_target" {
  description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
  type        = string
}

module "tfc_variables_global" {
  source = "../modules/tfc_variables"
  depends_on = [
    module.tfc_workspaces
  ]
  category     = "terraform"
  workspace_id = module.tfc_workspaces.tfe_workspace[0]
  variable_list = [
    {
      description = "Intersight Organization."
      hcl         = false
      key         = "organization"
      sensitive   = false
      value       = var.organization
    },
    {
      description = "Domain Name."
      hcl         = false
      key         = "domain_name"
      sensitive   = false
      value       = var.domain_name
    },
    {
      description = "Primary DNS Server."
      hcl         = false
      key         = "dns_primary"
      sensitive   = false
      value       = var.dns_primary
    },
    {
      description = "Secondary DNS Server."
      hcl         = false
      key         = "dns_secondary"
      sensitive   = false
      value       = var.dns_secondary
    },
    {
      description = "IKS Cluster Name."
      hcl         = false
      key         = "cluster_name"
      sensitive   = false
      value       = var.cluster_name
    },
    {
      description = "Network Prefix for IP Pool Policy."
      hcl         = false
      key         = "network_prefix"
      sensitive   = false
      value       = var.network_prefix
    },
    {
      description = "IP Pool Gateway last Octet."
      hcl         = false
      key         = "network_prefix"
      sensitive   = false
      value       = var.network_prefix
    },
    {
      description = "IP Pool Starting Address."
      hcl         = false
      key         = "ip_pool_from"
      sensitive   = false
      value       = var.ip_pool_from
    },
    {
      description = "IP Pool Size."
      hcl         = false
      key         = "ip_pool_size"
      sensitive   = false
      value       = var.ip_pool_size
    },
    {
      description = "vSphere Server registered as a Target in Intersight."
      hcl         = false
      key         = "vsphere_target"
      sensitive   = false
      value       = var.vsphere_target
    },
  ]
}
