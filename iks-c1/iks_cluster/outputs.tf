
output "iks_cluster" {
  description = "moid of the IKS Cluster."
  value       = module.iks_cluster.cluster_moid
}

# Wait for cluster to come up and then output the kubeconfig, if successful
output "kube_config" {
  description = "Kubernetes Configuration File."
  value       = intersight_kubernetes_cluster_profile.kubeprofaction.kube_config[0].kube_config
}
