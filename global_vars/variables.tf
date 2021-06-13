#-------------------------------
# Intersight Provider Variables
#-------------------------------
variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}
output "endpoint" {
  description = "Intersight URL."
  value       = var.endpoint
}

#-----------------------------------
# Intersight Organization Variables
#-----------------------------------
variable "organization" {
  default     = "default"
  description = "Intersight Organization."
  type        = string
}
output "organization" {
  description = "Intersight Organization Name."
  value       = var.organization
}

#-----------------------------------
# Prefix Variable
#-----------------------------------
variable "network_prefix" {
  default     = "10.200.0"
  description = "Network Prefix to Assign to DNS/NTP Servers & vCenter Target default values."
  type        = string
  validation {
    condition     = (can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.network_prefix)))
    error_message = "The network_prefix must be in the format X.X.X."
  }
}


#-----------------------------------
# DNS Variables
#-----------------------------------
variable "domain_name" {
  default     = "demo.intra"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}
output "domain_name" {
  description = "Domain Name."
  value       = var.domain_name
}

variable "dns_primary" {
  default     = "100"
  description = "Primary DNS Server for Kubernetes Sysconfig Policy or node id of the server."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.dns_primary)) ||
      can(regex("^[0-9]{1,3}$", var.dns_primary))
    )
    error_message = "The dns_primary must be in the format X.X.X.X or X."
  }
}
output "dns_primary" {
  description = "Primary DNS Server."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.dns_primary))}${var.dns_primary}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.dns_primary))}${join(".", [var.network_prefix, var.dns_primary])}%{endif}
  EOT
  )
}

variable "dns_secondary" {
  default     = ""
  description = "Secondary DNS Server for Kubernetes Sysconfig Policy."
  type        = string
}
output "dns_secondary" {
  description = "Secondary DNS Server."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.dns_secondary))}${var.dns_secondary}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.dns_secondary))}${join(".", [var.network_prefix, var.dns_secondary])}%{endif}
  EOT
  )
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
  description = "Timezone."
  value       = var.timezone
}

variable "ntp_primary" {
  default     = ""
  description = "Primary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns_primary."
  type        = string
}
output "ntp_primary" {
  description = "Primary NTP Server."
  #value       = var.ntp_primary != "" ? var.ntp_primary : var.dns_primary
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.ntp_primary))}var.ntp_primary%{endif}
  %{if can(regex("^$", var.ntp_primary)) &&
    can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.dns_primary))}${var.dns_primary}%{endif}
  %{if can(regex("^$", var.ntp_primary)) &&
  can(regex("^[0-9]{1,3}$", var.dns_primary))}${join(".", [var.network_prefix, var.dns_primary])}%{endif}
  EOT
)
}

variable "ntp_secondary" {
  default     = ""
  description = "Secondary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns_secondary."
  type        = string
}
output "ntp_secondary" {
  description = "Secondary NTP Server."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]+\\.{3}", var.ntp_secondary))}var.ntp_secondary%{endif}
  %{if can(regex("^$", var.ntp_secondary)) &&
    can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.dns_secondary))}${var.dns_secondary}%{endif}
  %{if can(regex("^$", var.ntp_secondary)) &&
  can(regex("^[0-9]{1,3}$", var.dns_secondary))}${join(".", [var.network_prefix, var.dns_secondary])}%{endif}
  EOT
)
}

#----------------------
# IKS Cluster Variable
#----------------------
variable "cluster_name" {
  default     = "iks"
  description = "Intersight Kubernetes Service Cluster Name."
  type        = string
}
output "cluster_name" {
  description = "Intersight Kubernetes Service Cluster Name."
  value       = var.cluster_name
}


#------------------------------
# Intersight IP Pool Variables
#------------------------------
variable "ip_pool" {
  default     = ""
  description = "Intersight Kubernetes Service IP Pool.  Default name is {cluster_name}_ip_pool"
  type        = string
}
output "ip_pool" {
  description = "IP Pool Policy Name."
  value       = var.ip_pool != "" ? var.ip_pool : join("_", [var.cluster_name, "ip_pool"])
}

variable "ip_pool_netmask" {
  default     = "255.255.255.0"
  description = "IP Pool Netmask."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.ip_pool_netmask))
    )
    error_message = "The ip_pool_netmask must be in the format X.X.X.X."
  }
}
output "ip_pool_netmask" {
  description = "IP Pool Netmask Value."
  value       = var.ip_pool_netmask
}

variable "ip_pool_gateway" {
  default     = "254"
  description = "IP Pool Gateway last Octet.  The var.network_prefix will be combined with ip_pool_gateway for the Gateway Address."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.ip_pool_gateway)) ||
      can(regex("^[0-9]{1,3}$", var.ip_pool_gateway))
    )
    error_message = "The ip_pool_gateway must be in the format X.X.X.X or X."
  }
}
output "ip_pool_gateway" {
  description = "IP Pool Gateway Value."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.ip_pool_gateway))}${var.ip_pool_gateway}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.ip_pool_gateway))}${join(".", [var.network_prefix, var.ip_pool_gateway])}%{endif}
  EOT
  )
}

variable "ip_pool_from" {
  default     = "20"
  description = "IP Pool Starting IP last Octet.  The var.network_prefix will be combined with ip_pool_from for the Starting Address."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}$", var.ip_pool_from))
    )
    error_message = "The ip_pool_from must be in the format X."
  }
}
output "ip_pool_from" {
  description = "IP Pool Starting IP Value."
  value       = join(".", [var.network_prefix, var.ip_pool_from])
}

variable "ip_pool_size" {
  default     = "30"
  description = "IP Pool Block Size."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}$", var.ip_pool_size))
    )
    error_message = "The ip_pool_size must be in the X."
  }
}
output "ip_pool_size" {
  description = "IP Pool Block Size."
  value       = var.ip_pool_size
}


#-----------------------------------------
# Kubernetes Policy Names
#-----------------------------------------
variable "k8s_version_policy" {
  default     = ""
  description = "Kubernetes Version Policy Name.  Default name is {cluster_name}-k8s-version."
  type        = string
}
output "k8s_version_policy" {
  description = "Kubernetes Version Policy Name."
  value       = var.k8s_version_policy != "" ? var.k8s_version_policy : join("-", [var.cluster_name, "k8s-version"])
}

variable "k8s_trusted_registry" {
  default     = ""
  description = "Kubernetes Trusted Registry Policy Name.  Default name is {cluster_name}-registry."
  type        = string
}
output "k8s_trusted_registry" {
  description = "Kubernetes Trusted Registry Policy Name."
  value       = var.k8s_trusted_registry != "" ? var.k8s_trusted_registry : join("-", [var.cluster_name, "registry"])
}

variable "k8s_vm_network_policy" {
  default     = ""
  description = "Kubernetes Network/System Configuration Policy (CIDR, dns, ntp, etc.).  Default name is {cluster_name}-sysconfig."
  type        = string
}
output "k8s_vm_network_policy" {
  description = "Kubernetes VM Network Policy Name."
  value       = var.k8s_vm_network_policy != "" ? var.k8s_vm_network_policy : join("-", [var.cluster_name, "sysconfig"])
}

variable "k8s_vm_infra_policy" {
  default     = ""
  description = "Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster_name}-vm-infra-config."
  type        = string
}
output "k8s_vm_infra_policy" {
  description = "Kubernetes VM Infrastructure Policy Name."
  value       = var.k8s_vm_infra_policy != "" ? var.k8s_vm_infra_policy : join("-", [var.cluster_name, "vm-infra-config"])
}


#--------------------------------
# K8S VM Infra Policy Variables
#--------------------------------
variable "vsphere_target" {
  default     = "210"
  description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
  type        = string
  validation {
    condition = (
      can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$", var.vsphere_target)) ||
      can(regex("^[0-9]{1,3}$", var.vsphere_target)) ||
      can(regex("^[[:alnum:]]+", var.vsphere_target))
    )
    error_message = "The vsphere_target must be in the format hostname or IPv4 Address or just a number."
  }
}
output "vsphere_target" {
  description = "vSphere Target."
  value = trimspace(<<-EOT
  %{if can(regex("[\\d]{1,3}\\.[\\d]{1,3}\\.", var.vsphere_target))}${var.vsphere_target}%{endif}
  %{if can(regex("^[0-9]{1,3}$", var.vsphere_target))}${join(".", [var.network_prefix, var.vsphere_target])}%{endif}
  %{if can(regex("^[[:alnum:]]+", var.vsphere_target))}${var.vsphere_target}%{endif}
  EOT
  )
}
