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
  name                         = local.cluster_name
  ip_pool_moid                 = local.ip_pool
  load_balancer                = var.load_balancers
  net_config_moid              = local.k8s_network_cidr
  ssh_key                      = var.ssh_key
  ssh_user                     = var.ssh_user
  sys_config_moid              = local.k8s_nodeos_config
  trusted_registry_policy_moid = local.k8s_trusted_registry
  tags                         = var.tags
}

output "iks_cluster" {
  value = module.iks_cluster.cluster_moid
}

module "control_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${local.cluster_name}-master_profile"
  profile_type = "ControlPlane"
  desired_size = var.master_desired_size
  max_size     = var.master_max_size
  ip_pool_moid = local.ip_pool
  cluster_moid = module.cluster.cluster_moid
  version_moid = module.k8s_version_policy

}

module "worker_profile" {
  source       = "terraform-cisco-modules/iks/intersight//modules/node_profile"
  name         = "${var.cluster_name}-worker_profile"
  profile_type = "Worker"
  desired_size = var.worker_desired_size
  max_size     = var.worker_max_size
  ip_pool_moid = local.ip_pool
  cluster_moid = module.cluster.cluster_moid
  version_moid = module.k8s_version_policy

}
module "master_instance_type" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${var.cluster_name}-master"
  instance_type_moid = trimspace(<<-EOT
  %{if var.master_instance_type == "small"~}${local.k8s_instance_small}%{endif~}
  %{if var.master_instance_type == "medium"~}${local.k8s_instance_medium}%{endif~}
  %{if var.master_instance_type == "large"~}${local.k8s_instance_large}%{endif~}
  EOT
  )
  node_group_moid          = module.control_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  tags                     = var.tags
}
module "worker_instance_type" {
  source = "terraform-cisco-modules/iks/intersight//modules/infra_provider"
  name   = "${var.cluster_name}-worker"
  instance_type_moid = trimspace(<<-EOT
  %{if var.worker_instance_type == "small"~}${local.k8s_instance_small}%{endif~}
  %{if var.worker_instance_type == "medium"~}${local.k8s_instance_medium}%{endif~}
  %{if var.worker_instance_type == "large"~}${local.k8s_instance_large}%{endif~}
  EOT
  )
  node_group_moid          = module.worker_profile.node_group_profile_moid
  infra_config_policy_moid = module.infra_config_policy.infra_config_moid
  tags                     = var.tags
}

# Wait for cluster to come up and then output the kubeconfig, if successful
output "kube_config" {
  value = intersight_kubernetes_cluster_profile.kubeprofaction.kube_config[0].kube_config
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
  k8s_vm_network_policy = yamldecode(data.terraform_remote_state.iks_policies.outputs.k8s_vm_network_policy)
}
