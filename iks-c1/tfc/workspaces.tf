module "tfc_workspaces" {
  source = "../../../terraform-cloud/modules/tfc_workspaces"
  depends_on = [
    module.tfc_agent_pool
  ]
  tfc_oath_token = var.tfc_oath_token
  tfc_org_name   = var.tfc_organization
  workspace_list = [
    {
      auto_apply        = false
      agent_pool        = ""
      description       = "Global Variables Workspace"
      exec_mode         = "remote"
      name              = "${var.cluster_name}_global_vars"
      queue_all_runs    = false
      terraform_version = var.terraform_version
      vcs_repo          = var.vcs_repo
      working_dir       = "${var.cluster_name}/global_vars"
    },
    {
      auto_apply        = false
      agent_pool        = ""
      description       = "Kubernetes Policies Workspace"
      exec_mode         = "remote"
      name              = "${var.cluster_name}_iks_policies"
      queue_all_runs    = false
      terraform_version = var.terraform_version
      vcs_repo          = var.vcs_repo
      working_dir       = "${var.cluster_name}/iks_policies"
    },
    {
      auto_apply        = false
      agent_pool        = ""
      description       = "Intersight Kubernetes Service Workspace"
      exec_mode         = "remote"
      name              = "${var.cluster_name}_iks_cluster"
      queue_all_runs    = false
      terraform_version = var.terraform_version
      vcs_repo          = var.vcs_repo
      working_dir       = "${var.cluster_name}/iks_cluster"
    },
    {
      auto_apply        = false
      agent_pool        = ""
      description       = "IWO Application Workspace"
      exec_mode         = "remote"
      name              = "${var.cluster_name}_app_iwo"
      queue_all_runs    = false
      terraform_version = var.terraform_version
      vcs_repo          = var.vcs_repo
      working_dir       = "${var.cluster_name}/app_iwo"
    },
    {
      auto_apply        = false
      agent_pool        = ""
      description       = "Sample Application Workspace"
      exec_mode         = "remote"
      name              = "${var.cluster_name}_app_sample"
      queue_all_runs    = false
      terraform_version = var.terraform_version
      vcs_repo          = var.vcs_repo
      working_dir       = "${var.cluster_name}/app_sample"
    },
  ]
}

output "tfc_workspaces" {
  description = "Terraform Cloud Workspace ID(s)."
  value       = module.tfc_workspaces
}
