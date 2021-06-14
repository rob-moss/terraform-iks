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
  workspace_list = {
    "global_vars" = {
      auto_apply                = true
      agent_pool                = ""
      description               = "Global Variables Workspace."
      execution_mode            = "remote"
      global_remote_state       = true
      name                      = "${var.cluster_name}_global_vars"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "global_vars"
    },
    "iks" = {
      auto_apply                = true
      agent_pool                = ""
      description               = "Intersight Kubernetes Service Workspace."
      execution_mode            = "remote"
      global_remote_state       = false
      name                      = "${var.cluster_name}_iks"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "iks"
    },
    "kube" = {
      auto_apply                = true
      agent_pool                = ""
      description               = "Intersight Kubernetes Service - kube_config Workspace."
      execution_mode            = "remote"
      global_remote_state       = true
      name                      = "${var.cluster_name}_kube"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "kube"
    },
    "iwo" = {
      auto_apply                = true
      agent_pool                = module.tfc_agent_pool.tfc_agent_pool
      description               = "Application Workspace - Intersight Workload Optimizer."
      execution_mode            = "agent"
      global_remote_state       = false
      name                      = "${var.cluster_name}_iwo"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "iwo"
    },
    "app_hello" = {
      auto_apply                = true
      agent_pool                = module.tfc_agent_pool.tfc_agent_pool
      description               = "Application Workspace - Hello Kubernetes."
      execution_mode            = "agent"
      global_remote_state       = false
      name                      = "${var.cluster_name}_app_hello"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "app_hello"
    },
    "remove" = {
      auto_apply                = true
      agent_pool                = ""
      description               = "Workspace used to Destroy IKS Cluster."
      execution_mode            = "remote"
      global_remote_state       = false
      name                      = "${var.cluster_name}_remove"
      queue_all_runs            = false
      remote_state_consumer_ids = []
      terraform_version         = var.terraform_version
      trigger_prefixes          = []
      vcs_repo                  = var.vcs_repo
      working_directory         = "remove"
    },
  }
}

output "tfc_workspaces" {
  description = "Terraform Cloud Workspace ID(s)."
  value       = module.tfc_workspaces
}
