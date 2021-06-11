module "tfc_agent_pool" {
  source       = "../modules/tfc_agent_pool"
  agent_pool   = var.agent_pool
  tfc_org_name = var.tfc_org_name
}

output "tfc_agent_pool" {
  value = module.tfc_agent_pool
}
