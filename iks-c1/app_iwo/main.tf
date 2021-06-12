#---------------------------------------------
# Get Outputs from the IKS Policies Workspace
#---------------------------------------------
data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_global_vars
    }
  }
}

data "terraform_remote_state" "iks_cluster" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_iks_cluster
    }
  }
}

resource "helm_release" "iwok8scollector" {
  name       = "iwok8scollector"
  namespace = "default"
  #  namespace = "iwo-collector"
  repository = "https://prathjan.github.io/helm-chart/iwok8scollector-0.6.2.tgz"
  chart = "iwocollector"
  set {
    name  = "iwoServerVersion"
    value = "8.0"
  }
  set {
    name  = "collectorImage.tag"
    value = "8.0.6"
  }
  set {
    name  = "targetName"
    value = "${local.cluster_name}_app_sample"
  }
}

locals {
  # IKS Cluster Variables
  cluster_name = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
}
