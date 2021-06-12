module "tfc_variables_app_iwo" {
  source = "../../../terraform-cloud/modules/tfc_variables"
  depends_on = [
    module.tfc_workspaces
  ]
  category     = "terraform"
  workspace_id = module.tfc_workspaces.tfe_workspace_id[3]
  variable_list = [
    {
      description = "Terraform Cloud Organization."
      hcl         = false
      key         = "tfc_organization"
      sensitive   = false
      value       = var.tfc_organization
    },
    {
      description = "global_vars Workspace."
      hcl         = false
      key         = "ws_global_vars"
      sensitive   = false
      value       = "${var.cluster_name}_global_vars"
    },
    {
      description = "iks_cluster Workspace."
      hcl         = false
      key         = "ws_iks_cluster"
      sensitive   = false
      value       = "${var.cluster_name}_iks_cluster"
    },
  ]
}
