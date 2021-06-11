#-------------------------
# Intersight Organization
#-------------------------
output "organization" {
  value = var.organization
}

output "organization_moid" {
  value = data.intersight_organization_organization.organization_moid
}


#-----------------------------
# Kubernetes Policies Outputs
#-----------------------------
output "ip_pool" {
  value = module.ip_pool.ip_pool_moid
}

#-----------------------------
# Kubernetes Policies Outputs
#-----------------------------
output "k8s_instance_small" {
  value = module.k8s_instance_small.worker_profile_moid
}

output "k8s_instance_medium" {
  value = module.k8s_instance_medium.worker_profile_moid
}

output "k8s_instance_large" {
  value = module.k8s_instance_large.worker_profile_moid
}

output "k8s_network_cidr" {
  value = module.k8s_vm_network_policy.network_policy_moid
}

output "k8s_nodeos_config" {
  value = module.k8s_vm_network_policy.sys_config_policy_moid
}

output "k8s_trusted_registry" {
  value = module.k8s_trusted_registry.trusted_registry_moid
}

output "k8s_version_policy" {
  value = module.k8s_version_policy.version_policy_moid
}

output "k8s_vm_infra_policy" {
  value = module.k8s_vm_infra_policy.infra_provider_moid
}
