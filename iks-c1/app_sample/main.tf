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

resource helm_release helloiksfrtfcb {
  name       = "hello_iks_app"
  namespace = "default"
  chart = "https://prathjan.github.io/helm-chart/helloiks-0.1.0.tgz"

  set {
    name  = "MESSAGE"
    value = "Hello Intersight Kubernetes Service from Terraform Cloud for Business!!"
  }
}
