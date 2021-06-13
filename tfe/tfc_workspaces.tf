#__________________________________________________________
#
# Terraform Cloud Workspaces
#__________________________________________________________

module "tfc_workspaces" {
  source = "../../terraform-cloud/modules/tfc_workspaces"
  depends_on = [
    module.tfc_agent_pool
  ]
  tfc_oath_token = var.tfc_oath_token
  tfc_org_name   = var.tfc_organization
  workspace_list = [
    {
      auto_apply          = true
      agent_pool          = ""
      description         = "Global Variables Workspace."
      exec_mode           = "remote"
      global_remote_state = true
      name                = "${var.cluster_name}_global_vars"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "global_vars"
    },
    {
      auto_apply          = true
      agent_pool          = ""
      description         = "Intersight Kubernetes Service Workspace."
      exec_mode           = "remote"
      global_remote_state = false
      name                = "${var.cluster_name}_iks"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "iks"
    },
    {
      auto_apply          = true
      agent_pool          = ""
      description         = "Intersight Kubernetes Service - kube_config Workspace."
      exec_mode           = "remote"
      global_remote_state = true
      name                = "${var.cluster_name}_kube"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "kube"
    },
    {
      auto_apply          = true
      agent_pool          = module.tfc_agent_pool.tfc_agent_pool
      description         = "Application Workspace - Intersight Workload Optimizer."
      exec_mode           = "agent"
      global_remote_state = false
      name                = "${var.cluster_name}_iwo"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "iwo"
    },
    {
      auto_apply          = true
      agent_pool          = module.tfc_agent_pool.tfc_agent_pool
      description         = "Application Workspace - Hello Kubernetes."
      exec_mode           = "agent"
      global_remote_state = false
      name                = "${var.cluster_name}_app_hello"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "app_hello"
    },
    {
      auto_apply          = true
      agent_pool          = ""
      description         = "Workspace used to Destroy IKS Cluster."
      exec_mode           = "remote"
      global_remote_state = false
      name                = "${var.cluster_name}_remove"
      queue_all_runs      = false
      terraform_version   = var.terraform_version
      vcs_repo            = var.vcs_repo
      working_dir         = "remove"
    },
  ]
}

output "tfc_workspaces" {
  description = "Terraform Cloud Workspace ID(s)."
  value       = module.tfc_workspaces
}
