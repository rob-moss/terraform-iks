#----------------------------------
# Terraform Cloud Organization
#----------------------------------
variable "tfc_organization" {
  default     = "DevNet"
  description = "Terraform Cloud Organization."
  type        = string
}


#-------------------------------
# Intersight Provider Variables
#-------------------------------
variable "api_key" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "secret_key" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}


#----------------------------
# Global Variables Workspace
#----------------------------
variable "ws_global_vars" {
  default     = "global_vars"
  description = "Global Variable Workspace Name"
  type        = string
}


#-----------------------------------------
# Kubernetes Network CIDR/System Policies
#-----------------------------------------
variable "cni" {
  type        = string
  description = "Supported CNI type. Currently we only support Calico.\r\n* Calico - Calico CNI plugin as described in:\r\n https://github.com/projectcalico/cni-plugin"
  default     = "Calico"
}

variable "k8s_pod_cidr" {
  default     = "100.65.0.0/64"
  description = "Pod CIDR Block to be used to assign Pod IP Addresses."
  type        = string
}

variable "k8s_service_cidr" {
  default     = "100.64.0.0/64"
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
  default     = ["Management"]
  description = "vSphere Port Group to assign the K8S Cluster Deployment."
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
  type        = list(string)
  description = "List of root CA Signed Registries."
  default     = []
}

variable "unsigned_registries" {
  type        = list(string)
  description = "List of unsigned registries to be supported."
  default     = []
}


#--------------------------
# Kubernetes Policies Tags
#--------------------------
variable "tags" {
  default     = []
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = list(map(string))
}
