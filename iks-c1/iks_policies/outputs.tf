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
# IP Pool Outputs
#-----------------------------
output "ip_pool" {
  description = "moid of the IP Pool"
  value       = module.ip_pool.ip_pool_moid
}

#-----------------------------
# Kubernetes Policies Outputs
#-----------------------------
output "k8s_instance_small" {
  description = "moid of the Small Kubernetes Instance Type."
  value       = module.k8s_instance_small.worker_profile_moid
}

output "k8s_instance_medium" {
  description = "moid of the Medium Kubernetes Instance Type."
  value       = module.k8s_instance_medium.worker_profile_moid
}

output "k8s_instance_large" {
  description = "moid of the Large Kubernetes Instance Type."
  value       = module.k8s_instance_large.worker_profile_moid
}

output "k8s_network_cidr" {
  description = "moid of the Kubernetes CIDR Policy."
  value       = module.k8s_vm_network_policy.network_policy_moid
}

output "k8s_nodeos_config" {
  description = "moid of the Kubernetes Node OS Config Policy."
  value       = module.k8s_vm_network_policy.sys_config_policy_moid
}

output "k8s_trusted_registry" {
  description = "moid of the Kubernetes Trusted Registry Policy."
  value       = module.k8s_trusted_registry.trusted_registry_moid
}

output "k8s_version_policy" {
  description = "moid of the Kubernetes Version Policy."
  value       = module.k8s_version_policy.version_policy_moid
}

output "k8s_vm_infra_policy" {
  description = "moid of the Kubernetes VM Infrastructure Policy."
  value       = module.k8s_vm_infra_policy.infra_provider_moid
}
