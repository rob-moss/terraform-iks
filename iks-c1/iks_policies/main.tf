#---------------------------------------------
# Get Outputs from the IKS Policies Workspace
#---------------------------------------------
data "terraform_remote_state" "global" {
  backend = "remote"
  config  = {
    organization  = local.tfc_organization
    workspaces    = {
      name  = var.ws_global_vars
    }
  }
}


#--------------------------------------
# Get the Intersight Organization moid
#--------------------------------------
data "intersight_organization_organization" "organization" {
  name  = local.organization
}


#---------------------------------------
# Create the IP Pool
#---------------------------------------
module "ip_pool" {
  source            = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  org_name          = local.organization
  name              = local.ip_pool
  gateway           = local.ip_pool_gateway
  netmask           = local.netmask
  pool_size         = local.pool_size
  primary_dns       = local.dns_primary
  secondary_dns     = local.dns_secondary
  starting_address  = local.ip_pool_from
  tags              = var.tags
}


#---------------------------------------
# Create the Kubernetes VM Infra Config
#---------------------------------------
module "k8s_vm_infra_policy" {
  source            = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  org_name          = local.organization
  name              = local.k8s_vm_infra_policy
  device_name       = local.vsphere_target
  vc_password       = var.vsphere_password
  vc_cluster        = var.vsphere_cluster
  vc_datastore      = var.vsphere_datastore
  vc_portgroup      = var.vsphere_portgroup
  vc_resource_pool  = var.vsphere_resource_pool
  tags              = var.tags
}


#------------------------------------------------
# Create the Kubernetes VM Node OS Config Policy
#------------------------------------------------
module "k8s_vm_network_policy" {
  source        = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  org_name      = local.organization
  policy_name   = local.k8s_vm_network_policy
  cni           = var.cni
  dns_servers   = trimspace(<<-EOT
  %{if local.dns_secondary == ""~}${[local.dns_primary]}
  %{else}${[local.dns_primary, local.dns_secondary]}%{endif~}
  EOT
  )
  domain_name   = local.domain_name
  ntp_servers   = trimspace(<<-EOT
  %{if local.ntp_secondary == ""~}${[local.ntp_primary]}
  %{else}${[local.ntp_primary, local.ntp_secondary]}%{endif~}
  EOT
  )
  pod_cidr      = var.k8s_pod_cidr
  service_cidr  = var.k8s_service_cidr
  timezone      = local.timezone
  tags          = var.tags
}


#---------------------------------------
# Create the Kubernetes Version Policy
#---------------------------------------
module "k8s_version_policy" {
  source            = "terraform-cisco-modules/iks/intersight//modules/version"
  org_name          = local.organization
  k8s_version_name  = local.k8s_version_policy
  k8s_version       = var.k8s_version
  tags              = var.tags
}


#-------------------------------------------------
# Create the Kubernetes VM Instance Type Policies
# * Small
# * Medium
# * Large
#-------------------------------------------------
module "k8s_instance_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [var.cluster_name, "small"])
  cpu       = 4
  disk_size = 40
  memory    = 16384
  tags      = var.tags
}

module "k8s_instance_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [var.cluster_name, "medium"])
  cpu       = 8
  disk_size = 60
  memory    = 24576
  tags      = var.tags
}

module "k8s_instance_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [var.cluster_name, "large"])
  cpu       = 12
  disk_size = 80
  memory    = 32768
  tags      = var.tags
}


#-----------------------------------------------
# Create the Kubernetes Trusted Registry Policy
#-----------------------------------------------
module "k8s_trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  org_name            = local.organization
  policy_name         = local.k8s_trusted_registry
  root_ca_registries  = var.unsigned_registries
  unsigned_registries = var.unsigned_registries
  tags                = var.tags
}


#---------------------------------------------------
# Pull Global Attributes from global_vars Workspace
#---------------------------------------------------
locals {
  # Intersight Provider Variables
  endpoint      = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization  = yamldecode(data.terraform_remote_state.global.outputs.organization)
  # DNS Variables
  dns_primary   = yamldecode(data.terraform_remote_state.global.outputs.dns_primary)
  dns_secondary = yamldecode(data.terraform_remote_state.global.outputs.dns_secondary)
  domain_name   = yamldecode(data.terraform_remote_state.global.outputs.domain_name)
  # Time Variables
  ntp_primary   = yamldecode(data.terraform_remote_state.global.outputs.ntp_primary)
  ntp_secondary = yamldecode(data.terraform_remote_state.global.outputs.ntp_secondary)
  timezone      = yamldecode(data.terraform_remote_state.global.outputs.timezone)
  # IKS Cluster Variable
  cluster_name  = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
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
  vsphere_target  = yamldecode(data.terraform_remote_state.global.outputs.vsphere_target)
}
