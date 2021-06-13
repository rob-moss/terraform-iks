#__________________________________________________________
#
# Get Outputs from the Global Variables Workspace
#__________________________________________________________

data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_global_vars
    }
  }
}


#__________________________________________________________
#
# Assign Global Attributes from global_vars Workspace
#__________________________________________________________

locals {
  # Intersight Provider Variables
  endpoint = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization = yamldecode(data.terraform_remote_state.global.outputs.organization)
  # IKS Cluster Variable
  cluster_name = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
}

data "intersight_organization_organization" "organization_moid" {
  name = local.organization
}

#__________________________________________________
#
# Delete the Intersight Kubernetes Service Cluster
#__________________________________________________

resource "intersight_kubernetes_cluster_profile" "delete" {
  action              = "Delete"
  name                = local.cluster_name
  wait_for_completion = true
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.results.0.moid
  }
}


