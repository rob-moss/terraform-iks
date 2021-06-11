#-------------------------------
# Intersight Provider Variables
#-------------------------------
variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL"
  type        = string
}
output "endpoint" {
  value = var.endpoint
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
  value = var.organization
}

#-----------------------------------
# Prefix Variable
#-----------------------------------
variable "network_prefix" {
  default     = "10.200.0"
  description = "Network Prefix to Assign to DNS/NTP Servers & vCenter Target default values."
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
output "domain_name" {
  value = var.domain_name
}

variable "dns_primary" {
  default     = "100"
  description = "Primary DNS Server for Kubernetes Sysconfig Policy. If Using DevNet Sandbox default is {network_prefix}.100"
  type        = string
}
output "dns_primary" {
  value = trimspace(<<-EOT
  %{if var.dns_primary == "100"~}${join(".", [var.network_prefix, var.dns_primary])}
  %{else}${var.dns_primary}
  %{endif~}
  EOT
  )
}

variable "dns_secondary" {
  default     = ""
  description = "Secondary DNS Server for Kubernetes Sysconfig Policy."
  type        = string
}
output "dns_secondary" {
  value = var.dns_secondary
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

variable "ntp_primary" {
  default     = ""
  description = "Primary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns_primary."
  type        = string
}
output "ntp_primary" {
  value = var.ntp_primary != "" ? var.ntp_primary : var.dns_primary
}

variable "ntp_secondary" {
  default     = ""
  description = "Secondary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns_secondary."
  type        = string
}
output "ntp_secondary" {
  value = var.ntp_secondary != "" ? var.ntp_secondary : var.dns_secondary
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
  value = var.cluster_name
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
  value = var.ip_pool != "" ? var.ip_pool : join("_", [var.cluster_name, "ip_pool"])
}

variable "ip_pool_netmask" {
  default     = "255.255.255.0"
  description = "IP Pool Netmask."
  type        = string
}
output "ip_pool_netmask" {
  value = var.ip_pool_netmask
}

variable "ip_pool_gateway" {
  default     = "254"
  description = "IP Pool Gateway last Octet.  The var.network_prefix will be combined with ip_pool_gateway for the Gateway Address."
  type        = string
}
output "ip_pool_gateway" {
  value = join(".", [var.network_prefix, var.ip_pool_gateway])
}

variable "ip_pool_from" {
  default     = "20"
  description = "IP Pool Starting IP last Octet.  The var.network_prefix will be combined with ip_pool_from for the Gateway Address."
  type        = string
}
output "ip_pool_from" {
  value = join(".", [var.network_prefix, var.ip_pool_from])
}

variable "ip_pool_size" {
  default     = "30"
  description = "IP Pool Block Size."
  type        = string
}
output "ip_pool_size" {
  value = var.ip_pool_size
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
  value = var.k8s_version_policy != "" ? var.k8s_version_policy : join("-", [var.cluster_name, "k8s-version"])
}

variable "k8s_trusted_registry" {
  default     = ""
  description = "Kubernetes Trusted Registry Policy Name.  Default name is {cluster_name}-registry."
  type        = string
}
output "k8s_trusted_registry" {
  value = var.k8s_trusted_registry != "" ? var.k8s_trusted_registry : join("-", [var.cluster_name, "registry"])
}

variable "k8s_vm_network_policy" {
  default     = ""
  description = "Kubernetes Network/System Configuration Policy (CIDR, dns, ntp, etc.).  Default name is {cluster_name}-sysconfig."
  type        = string
}
output "k8s_vm_network_policy" {
  value = var.k8s_vm_network_policy != "" ? var.k8s_vm_network_policy : join("-", [var.cluster_name, "sysconfig"])
}

variable "k8s_vm_infra_policy" {
  default     = ""
  description = "Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster_name}-vm-infra-config."
  type        = string
}
output "k8s_vm_infra_policy" {
  value = var.k8s_vm_infra_policy != "" ? var.k8s_vm_infra_policy : join("-", [var.cluster_name, "vm-infra-config"])
}


#--------------------------------
# K8S VM Infra Policy Variables
#--------------------------------
variable "vsphere_target" {
  default     = "210"
  description = "vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox."
  type        = string
}
output "vsphere_target" {
  value = trimspace(<<-EOT
  %{if var.vsphere_target == "210"~}${join(".", [var.network_prefix, var.vsphere_target])}
  %{else}${var.vsphere_target}
  %{endif~}
  EOT
  )
}
