#-----------------------------------------
# Kubernetes Network CIDR/System Policies
#-----------------------------------------
variable "k8s_pod_cidr" {
  default     = "100.65.0.0/16"
  description = "Pod CIDR Block to be used to assign Pod IP Addresses."
  type        = string
}

variable "k8s_service_cidr" {
  default     = "100.64.0.0/16"
  description = "Service CIDR Block used to assign Cluster Service IP Addresses."
  type        = string
}

variable "k8s_version" {
  default     = "1.19.5"
  description = "Kubernetes Version to Deploy."
  type        = string
}


#--------------------------------
# K8S VM Infra Policy Variables
#--------------------------------
variable "vsphere_password" {
  description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
  sensitive   = true
  type        = string
}

variable "vsphere_cluster" {
  default     = "hx-demo"
  description = "vSphere Cluster to assign the K8S Cluster Deployment."
  type        = string
}

variable "vsphere_datastore" {
  default     = "hx-demo-ds1"
  description = "vSphere Datastore to assign the K8S Cluster Deployment."
  type        = string
}

variable "vsphere_portgroup" {
  default     = "Management"
  description = "vSphere Port Group to assign the K8S Cluster Deployment."
  type        = string
}

variable "vsphere_resource_pool" {
  default     = ""
  description = "vSphere Resource Pool to assign the K8S Cluster Deployment."
  type        = string
}

#------------------------------
# Trusted Registries Variables
#------------------------------
variable "root_ca_registries" {
  default     = "[]"
  description = "List of root CA Signed Registries."
  type        = string
}

variable "unsigned_registries" {
  default     = "[]"
  description = "List of unsigned registries to be supported."
  type        = string
}


#--------------------------
# Kubernetes Policies Tags
#--------------------------
variable "tags_policies" {
  default     = "[]"
  # default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = string
}


module "tfc_variables_iks_policies" {
  source = "../../../terraform-cloud/modules/tfc_variables"
  depends_on = [
    module.tfc_workspaces
  ]
  category     = "terraform"
  workspace_id = module.tfc_workspaces.tfe_workspace_id[1]
  variable_list = [
    {
      description = "Terraform Cloud Organization."
      hcl         = false
      key         = "tfc_organization"
      sensitive   = false
      value       = var.tfc_organization
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
    {
      description = "Kubernetes Network Pod CIDR."
      hcl         = false
      key         = "k8s_pod_cidr"
      sensitive   = false
      value       = var.k8s_pod_cidr
    },
    {
      description = "Kubernetes Network Service CIDR."
      hcl         = false
      key         = "k8s_service_cidr"
      sensitive   = false
      value       = var.k8s_service_cidr
    },
    {
      description = "Kubernetes Version."
      hcl         = false
      key         = "k8s_version"
      sensitive   = false
      value       = var.k8s_version
    },
    {
      description = "vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target."
      hcl         = false
      key         = "vsphere_password"
      sensitive   = true
      value       = var.vsphere_password
    },
    {
      description = "vSphere Cluster to assign the K8S Cluster Deployment."
      hcl         = false
      key         = "vsphere_cluster"
      sensitive   = false
      value       = var.vsphere_cluster
    },
    {
      description = "vSphere Datastore to assign the K8S Cluster Deployment."
      hcl         = false
      key         = "vsphere_datastore"
      sensitive   = false
      value       = var.vsphere_datastore
    },
    {
      description = "vSphere Port Group to assign the K8S Cluster Deployment."
      hcl         = false
      key         = "vsphere_portgroup"
      sensitive   = false
      value       = var.vsphere_portgroup
    },
    {
      description = "vSphere Resource Pool to assign the K8S Cluster Deployment."
      hcl         = false
      key         = "vsphere_resource_pool"
      sensitive   = false
      value       = var.vsphere_resource_pool
    },
    {
      description = "List of root CA Signed Registries."
      hcl         = true
      key         = "root_ca_registries"
      sensitive   = false
      value       = var.root_ca_registries
    },
    {
      description = "List of unsigned registries to be supported."
      hcl         = true
      key         = "unsigned_registries"
      sensitive   = false
      value       = var.unsigned_registries
    },
    {
      description = "Tags to be Associated with Objects Created in Intersight."
      hcl         = true
      key         = "tags"
      sensitive   = false
      value       = var.tags_policies
    },
  ]
}
