#----------------------------------------------------------
# Get Outputs from the Global and IKS Cluster Workspace(s)
#----------------------------------------------------------
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

data "intersight_kubernetes_cluster" "kube_config" {
  name = local.cluster_name
}

output "kube_config" {
    value = base64decode(data.intersight_kubernetes_cluster.kube_config.results[0].kube_config)
}

#---------------------------------
# Kubernetes Provider Settings
#---------------------------------
provider "helm" {
  kubernetes {
    host = local.kube_config.clusters[0].cluster.server
    client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
  }
}

resource "helm_release" "helloiksfrtfcb" {
  depends_on = [
    data.intersight_kubernetes_cluster.kube_config
  ]
  name        = "helloiksapp"
  namespace   = "default"
  chart       = "https://prathjan.github.io/helm-chart/helloiks-0.1.0.tgz"
  set {
    name  = "MESSAGE"
    value = "Hello Intersight Kubernetes Service from Terraform Cloud for Business!!"
  }
}

locals {
  # Intersight Provider Variables
  endpoint          = yamldecode(data.terraform_remote_state.global.outputs.endpoint)
  # Intersight Organization
  organization      = yamldecode(data.terraform_remote_state.global.outputs.organization)
  organization_moid = yamldecode(data.terraform_remote_state.iks_policies.outputs.organization_moid)
  # IKS Cluster Variables
  cluster_name      = yamldecode(data.terraform_remote_state.global.outputs.cluster_name)
  kube_config       = base64decode(data.intersight_kubernetes_cluster.kube_config.results[0].kube_config)
}
