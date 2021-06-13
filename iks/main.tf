#__________________________________________________________
#
# Get Outputs from the Global Variables Workspace
#__________________________________________________________

data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_global_vars
    }
  }
}


#__________________________________________________________
#
# Assign Global Attributes from global_vars Workspace
#__________________________________________________________

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


#__________________________________________________________
#
# GET the Intersight Organization moid
#__________________________________________________________

data "intersight_organization_organization" "organization_moid" {
  name = local.organization
}


#__________________________________________________________
#
# Create Kubernetes Policies
#__________________________________________________________

#______________________________________________
#
# Create the IP Pool
#______________________________________________

module "ip_pool" {
  source           = "terraform-cisco-modules/iks/intersight//modules/ip_pool"
  org_name         = local.organization
  name             = local.ip_pool
  gateway          = local.ip_pool_gateway
  netmask          = local.ip_pool_netmask
  pool_size        = local.ip_pool_size
  primary_dns      = local.dns_primary
  secondary_dns    = local.dns_secondary
  starting_address = local.ip_pool_from
  tags             = var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Infra Config
#______________________________________________

module "k8s_vm_infra_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/infra_config_policy"
  org_name         = local.organization
  name             = local.k8s_vm_infra_policy
  device_name      = local.vsphere_target
  vc_password      = var.vsphere_password
  vc_cluster       = var.vsphere_cluster
  vc_datastore     = var.vsphere_datastore
  vc_portgroup     = var.vsphere_portgroup
  vc_resource_pool = var.vsphere_resource_pool
  tags             = var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Node OS Config Policy
#______________________________________________

module "k8s_vm_network_policy" {
  source      = "terraform-cisco-modules/iks/intersight//modules/k8s_network"
  org_name    = local.organization
  policy_name = local.k8s_vm_network_policy
  cni         = var.cni
  dns_servers = [
    local.dns_primary,
    trimspace(<<-EOT
    %{if local.dns_secondary != ""~}${local.dns_secondary}%{endif~}
    EOT
    )
  ]
  domain_name = local.domain_name
  ntp_servers = [
    local.ntp_primary,
    trimspace(<<-EOT
    %{if local.ntp_secondary != ""~}${local.ntp_secondary}%{endif~}
    EOT
    )
  ]
  pod_cidr     = var.k8s_pod_cidr
  service_cidr = var.k8s_service_cidr
  timezone     = local.timezone
  tags         = var.tags
}

#______________________________________________
#
# Create the Kubernetes Version Policy
#______________________________________________

module "k8s_version_policy" {
  source           = "terraform-cisco-modules/iks/intersight//modules/version"
  org_name         = local.organization
  k8s_version_name = local.k8s_version_policy
  k8s_version      = var.k8s_version
  tags             = var.tags
}

#______________________________________________
#
# Create the Kubernetes VM Instance Type Policies
# * Small
# * Medium
# * Large
#______________________________________________

module "k8s_instance_small" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "small"])
  cpu       = 4
  disk_size = 40
  memory    = 16384
  tags      = var.tags
}

module "k8s_instance_medium" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "medium"])
  cpu       = 8
  disk_size = 60
  memory    = 24576
  tags      = var.tags
}

module "k8s_instance_large" {
  source    = "terraform-cisco-modules/iks/intersight//modules/worker_profile"
  org_name  = local.organization
  name      = join("-", [local.cluster_name, "large"])
  cpu       = 12
  disk_size = 80
  memory    = 32768
  tags      = var.tags
}

#______________________________________________
#
# Create the Kubernetes Trusted Registry Policy
#______________________________________________

module "k8s_trusted_registry" {
  source              = "terraform-cisco-modules/iks/intersight//modules/trusted_registry"
  org_name            = local.organization
  policy_name         = local.k8s_trusted_registry
  root_ca_registries  = var.unsigned_registries
  unsigned_registries = var.unsigned_registries
  tags                = var.tags
}


#__________________________________________________________
#
# Create Intersight Kubernetes Cluster
#__________________________________________________________

#______________________________________________
#
# Create the IKS Cluster Profile
#______________________________________________

module "iks_cluster" {
  depends_on = [
    module.ip_pool,
    module.k8s_instance_small,
    module.k8s_instance_medium,
    module.k8s_instance_large,
    module.k8s_trusted_registry,
    module.k8s_version_policy,
    module.k8s_vm_infra_policy,
    module.k8s_vm_network_policy,
  ]
  source              = "terraform-cisco-modules/iks/intersight//modules/cluster"
  org_name            = local.organization
  action              = var.action
  wait_for_completion = false
  name                = local.cluster_name
  load_balancer       = var.load_balancers
  ssh_key             = var.ssh_key
  ssh_user            = var.ssh_user
  tags                = var.tags
  # Attach Kubernetes Policies
  ip_pool_moid                 = module.ip_pool.ip_pool_moid
  net_config_moid              = module.k8s_vm_network_policy.network_policy_moid
  sys_config_moid              = module.k8s_vm_network_policy.sys_config_policy_moid
  trusted_registry_policy_moid = module.k8s_trusted_registry.trusted_registry_moid
}

#______________________________________________
#
# Create the Master Profile
#______________________________________________

module "master_profile" {
  depends_on = [
    module.iks_cluster,
  ]
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  desired_size = var.master_desired_size
  max_size     = var.master_max_size
  name         = "${local.cluster_name}-master_profile"
  profile_type = trimspace(<<-EOT
  %{if var.worker_desired_size == "0"~}ControlPlaneWorker
  %{else~}ControlPlane
  %{endif~}
  EOT
  )
  # Attach Kubernetes Policies
  cluster_moid = module.iks_cluster.cluster_moid
  ip_pool_moid = module.ip_pool.ip_pool_moid
  version_moid = module.k8s_version_policy.version_policy_moid
}

module "master_instance_type" {
  depends_on = [
    module.master_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-master"
  instance_type_moid = trimspace(<<-EOT
  %{if var.master_instance_type == "small"~}${module.k8s_instance_small.worker_profile_moid}%{endif~}
  %{if var.master_instance_type == "medium"~}${module.k8s_instance_medium.worker_profile_moid}%{endif~}
  %{if var.master_instance_type == "large"~}${module.k8s_instance_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid          = module.master_profile.node_group_profile_moid
  infra_config_policy_moid = module.k8s_vm_infra_policy.infra_config_moid
  tags                     = var.tags
}

#______________________________________________
#
# Create the Worker Profile
#______________________________________________

module "worker_profile" {
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on = [
    module.iks_cluster
  ]
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  desired_size = var.worker_desired_size
  max_size     = var.worker_max_size
  name         = "${local.cluster_name}-worker_profile"
  profile_type = "Worker"
  tags         = var.tags
  # Attach Kubernetes Policies
  cluster_moid = module.iks_cluster.cluster_moid
  ip_pool_moid = module.ip_pool.ip_pool_moid
  version_moid = module.k8s_version_policy.version_policy_moid
}

module "worker_instance_type" {
  # skip this module if the worker_desired_size is 0
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on = [
    module.worker_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-worker"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_instance_type == "small"~}${module.k8s_instance_small.worker_profile_moid}%{endif~}
  %{if var.worker_instance_type == "medium"~}${module.k8s_instance_medium.worker_profile_moid}%{endif~}
  %{if var.worker_instance_type == "large"~}${module.k8s_instance_large.worker_profile_moid}%{endif~}
  EOT
  )
  node_group_moid = trimspace(<<-EOT
  %{if var.worker_desired_size != "0"~}${module.worker_profile.node_group_profile_moid}%{endif~}
  EOT
  )
  infra_config_policy_moid = module.k8s_vm_infra_policy.infra_config_moid
  tags                     = var.tags
}
