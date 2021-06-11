#---------------------------------------------
# Get Outputs from the IKS Policies Workspace
#---------------------------------------------
data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_global_vars
    }
  }
}

#---------------------------------------------------
# Pull Global Attributes from global_vars Workspace
#---------------------------------------------------
locals {
  # Intersight Provider Variables
  endpoint = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization = yamldecode(data.terraform_remote_state.global.outputs.organization)
  # DNS Variables
  dns_primary   = yamldecode(data.terraform_remote_state.global.outputs.dns_primary)
  dns_secondary = yamldecode(data.terraform_remote_state.global.outputs.dns_secondary)
  domain_name   = yamldecode(data.terraform_remote_state.global.outputs.domain_name)
  # Time Variables
  ntp_primary   = yamldecode(data.terraform_remote_state.global.outputs.ntp_primary)
  ntp_secondary = yamldecode(data.terraform_remote_state.global.outputs.ntp_secondary)
  timezone      = yamldecode(data.terraform_remote_state.global.outputs.timezone)
  # IKS Cluster Variable
  cluster_name = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
  # IP Pool Variables
  ip_pool         = yamldecode(data.terraform_remote_state.global.outputs.ip_pool)
  ip_pool_netmask = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_netmask)
  ip_pool_gateway = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_gateway)
  ip_pool_from    = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_from)
  ip_pool_size    = yamldecode(data.terraform_remote_state.global.outputs.ip_pool_size)
  # Kubernetes Policy Names Variables
  k8s_trusted_registry  = yamldecode(data.terraform_remote_state.global.outputs.k8s_trusted_registry)
  k8s_version_policy    = yamldecode(data.terraform_remote_state.global.outputs.k8s_version_policy)
  k8s_vm_network_policy = yamldecode(data.terraform_remote_state.global.outputs.k8s_vm_network_policy)
  k8s_vm_infra_policy   = yamldecode(data.terraform_remote_state.global.outputs.k8s_vm_infra_policy)
  # vSphere Target Variable
  vsphere_target = yamldecode(data.terraform_remote_state.global.outputs.vsphere_target)
}

output "endpoint" {
  value = local.endpoint
}

output "organization" {
  value = local.organization
}

output "dns_primary" {
  value = local.dns_primary
}

output "dns_secondary" {
  value = local.dns_secondary
}

output "domain_name" {
  value = local.domain_name
}

output "ntp_primary" {
  value = local.ntp_primary
}

output "ntp_secondary" {
  value = local.ntp_secondary
}

output "timezone" {
  value = local.timezone
}

output "cluster_name" {
  value = local.cluster_name
}

output "ip_pool" {
  value = local.ip_pool
}

output "ip_pool_netmask" {
  value = local.ip_pool_netmask
}

output "ip_pool_gateway" {
  value = local.ip_pool_gateway
}

output "ip_pool_from" {
  value = local.ip_pool_from
}

output "ip_pool_size" {
  value = local.ip_pool_size
}

output "k8s_trusted_registry" {
  value = local.k8s_trusted_registry
}

output "k8s_version_policy" {
  value = local.k8s_version_policy
}

output "k8s_vm_network_policy" {
  value = local.k8s_vm_network_policy
}

output "k8s_vm_infra_policy" {
  value = local.k8s_vm_infra_policy
}

output "vsphere_target" {
  value = local.vsphere_target
}
