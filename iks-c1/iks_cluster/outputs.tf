
output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value       = module.iks_cluster.cluster_moid
}

output "master_profile" {
  description = "moid of the Master Node Profile."
  value       = module.master_profile.node_group_profile_moid
}

output "worker_profile" {
  description = "moid of the Worker Node Profile."
  value       = module.worker_profile.node_group_profile_moid
}

#---------------------------------------------------------------------------
# Wait for cluster to come up and then output the kubeconfig, if successful
#---------------------------------------------------------------------------
output "kube_config" {
  description = "Kubernetes Configuration File."
  value       = intersight_kubernetes_cluster_profile.deploy_iks_cluster.kube_config[0].kube_config
}
