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

data "terraform_remote_state" "iks_policies" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_iks_policies
    }
  }
}

#----------------------------------------------------------
# Create the Intersight Kubernetes Service Cluster Profile
#----------------------------------------------------------
module "iks_cluster" {
  source   = "terraform-cisco-modules/iks/intersight//modules/cluster"
  org_name = local.organization
  # action                        = "Unassign"
  # action                        = "Deploy"
  action                        = ""
  wait_for_completion           = true
  name                          = local.cluster_name
  ip_pool_moid                  = local.ip_pool
  load_balancer                 = var.load_balancers
  net_config_moid               = local.k8s_network_cidr
  ssh_key                       = var.ssh_key
  ssh_user                      = var.ssh_user
  sys_config_moid               = local.k8s_nodeos_config
  trusted_registry_policy_moid  = local.k8s_trusted_registry
  tags                          = var.tags
}

module "master_profile" {
  depends_on    = [
    module.iks_cluster
  ]
  source        = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name          = "${local.cluster_name}-master_profile"
  profile_type  = "ControlPlane"
  desired_size  = var.master_desired_size
  max_size      = var.master_max_size
  cluster_moid  = module.iks_cluster.cluster_moid
  ip_pool_moid  = local.ip_pool
  version_moid  = local.k8s_version_policy
}

module "master_instance_type" {
  depends_on    = [
    module.master_profile
  ]
  source        = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name          = "${local.cluster_name}-master"
  instance_type_moid = trimspace(<<-EOT
  %{if var.master_instance_type == "small"~}${local.k8s_instance_small}%{endif~}
  %{if var.master_instance_type == "medium"~}${local.k8s_instance_medium}%{endif~}
  %{if var.master_instance_type == "large"~}${local.k8s_instance_large}%{endif~}
  EOT
  )
  node_group_moid          = module.master_profile.node_group_profile_moid
  infra_config_policy_moid = local.k8s_vm_infra_policy
  tags                     = var.tags
}

module "worker_profile" {
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on    = [
    module.iks_cluster
  ]
  source        = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name          = "${local.cluster_name}-worker_profile"
  profile_type  = "Worker"
  desired_size  = var.worker_desired_size
  max_size      = var.worker_max_size
  cluster_moid  = module.iks_cluster.cluster_moid
  ip_pool_moid  = local.ip_pool
  version_moid  = local.k8s_version_policy

}

module "worker_instance_type" {
  # skip this module if the worker_desired_size is 0
  count = var.worker_desired_size == "0" ? 0 : 1
  depends_on    = [
    module.worker_profile
  ]
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${local.cluster_name}-worker"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_instance_type == "small"~}${local.k8s_instance_small}%{endif~}
  %{if var.worker_instance_type == "medium"~}${local.k8s_instance_medium}%{endif~}
  %{if var.worker_instance_type == "large"~}${local.k8s_instance_large}%{endif~}
  EOT
  )
  node_group_moid          = trimspace(<<-EOT
  %{if var.worker_desired_size != "0"~}${module.worker_profile.node_group_profile_moid}%{endif~}
  EOT
  )
  infra_config_policy_moid = local.k8s_vm_infra_policy
  tags                     = var.tags
}

data "intersight_kubernetes_cluster" "kube_config" {
  depends_on = [
    module.iks_cluster,
    module.master_instance_type
  ]
  name = local.cluster_name
}

output "kube_config" {
    value = data.intersight_kubernetes_cluster.kube_config
}

#---------------------------------------------------
# Pull Global Attributes from global_vars Workspace
#---------------------------------------------------
locals {
  # Intersight Provider Variables
  endpoint = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization      = yamldecode(data.terraform_remote_state.global.outputs.organization)
  organization_moid = yamldecode(data.terraform_remote_state.iks_policies.outputs.organization_moid)
  # IKS Cluster Variables
  cluster_name = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
  # Kubernetes Policy moid Variables
  ip_pool               = yamldecode(data.terraform_remote_state.iks_policies.outputs.ip_pool)
  k8s_instance_small    = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_instance_small)
  k8s_instance_medium   = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_instance_medium)
  k8s_instance_large    = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_instance_large)
  k8s_network_cidr      = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_network_cidr)
  k8s_nodeos_config     = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_nodeos_config)
  k8s_trusted_registry  = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_trusted_registry)
  k8s_version_policy    = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_version_policy)
  k8s_vm_infra_policy   = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_vm_infra_policy)
}
