module "tfc_variables_app_sample" {
  source = "../../../terraform-cloud/modules/tfc_variables"
  depends_on = [
    module.tfc_workspaces
  ]
  category     = "terraform"
  workspace_id = module.tfc_workspaces.tfe_workspace_id[5]
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
    {
      description = "Intersight API Key."
      hcl         = false
      key         = "api_key"
      sensitive   = true
      value       = var.api_key
    },
    {
      description = "Intersight Secret Key."
      hcl         = false
      key         = "secret_key"
      sensitive   = true
      value       = var.secret_key
    },
  ]
}
