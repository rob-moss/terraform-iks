module "tfc_agent_pool" {
  source       = "../../../terraform-cloud/modules/tfc_agent_pool"
  agent_pool   = var.agent_pool
  tfc_org_name = var.tfc_organization
}

output "tfc_agent_pool" {
  description = "Terraform Cloud Agent Pool ID."
  value       = module.tfc_agent_pool
}
