#Helm install of sample app on IKS
data "terraform_remote_state" "iks_cluster" {
  backend = "remote"
  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.ws_iks_cluster
    }
  }
}

resource helm_release iwok8scollector {
  name       = "iwo_k8s_collector"
  namespace = "default"
#  namespace = "iwo-collector"
#  repository = "https://prathjan.github.io/helm-chart"
  chart = "https://github.com/scotttyso/terraform-iks/helm-chart/helloiks-0.1.0.tgz"

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
    value = "sbcluster"
  }
}
