#----------------------------
# Global Variables Workspace
#----------------------------
variable "ws_iks_policies" {
  default     = "iks_policies"
  description = "Global Variable Workspace Name"
  type        = string
}


#---------------------
# IKS Cluster
#---------------------
variable "load_balancers" {
  default     = 3
  description = "Intersight Kubernetes Load Balancer count."
  type        = string
}

variable "ssh_user" {
  default     = "iksadmin"
  description = "Intersight Kubernetes Service Cluster Default User."
  type        = string
}

variable "ssh_key" {
  description = "Intersight Kubernetes Service Cluster SSH Public Key."
  sensitive   = false
  type        = string
}

variable "master_instance_type" {
  default     = "small"
  description = "K8S Master Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "master_desired_size" {
  default     = 1
  description = "K8S Master Desired Cluster Size."
  type        = string
}

variable "master_max_size" {
  default     = 1
  description = "K8S Master Maximum Cluster Size."
  type        = string
}

variable "worker_instance_type" {
  default     = "small"
  description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
  type        = string
}

variable "worker_desired_size" {
  default     = 1
  description = "K8S Worker Desired Cluster Size."
  type        = string
}

variable "worker_max_size" {
  default     = 4
  description = "K8S Worker Maximum Cluster Size."
  type        = string
}


#--------------------------
# Kubernetes Policies Tags
#--------------------------
variable "tags_cluster" {
  default     = "[]"
  description = "Tags to be Associated with Objects Created in Intersight."
  type        = string
}


module "tfc_variables_iks_cluster" {
  source = "../../../terraform-cloud/modules/tfc_variables"
  depends_on = [
    module.tfc_workspaces
  ]
  category     = "terraform"
  workspace_id = module.tfc_workspaces.tfe_workspace_id[2]
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
      description = "iks_policies Workspace."
      hcl         = false
      key         = "ws_iks_policies"
      sensitive   = false
      value       = "${var.cluster_name}_iks_policies"
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
      description = "Intersight Kubernetes Load Balancer count."
      hcl         = false
      key         = "load_balancers"
      sensitive   = false
      value       = var.load_balancers
    },
    {
      description = "Intersight Kubernetes Service Cluster Default User."
      hcl         = false
      key         = "ssh_user"
      sensitive   = false
      value       = var.ssh_user
    },
    {
      description = "Intersight Kubernetes Service Cluster Default User."
      hcl         = false
      key         = "ssh_key"
      sensitive   = true
      value       = var.ssh_key
    },
    {
      description = "K8S Master Virtual Machine Instance Type.  Options are {small|medium|large}."
      hcl         = false
      key         = "master_instance_type"
      sensitive   = false
      value       = var.master_instance_type
    },
    {
      description = "K8S Master Desired Cluster Size."
      hcl         = false
      key         = "master_desired_size"
      sensitive   = false
      value       = var.master_desired_size
    },
    {
      description = "K8S Master Maximum Cluster Size."
      hcl         = false
      key         = "master_max_size"
      sensitive   = false
      value       = var.master_max_size
    },
    {
      description = "K8S Worker Virtual Machine Instance Type.  Options are {small|medium|large}."
      hcl         = false
      key         = "worker_instance_type"
      sensitive   = false
      value       = var.worker_instance_type
    },
    {
      description = "K8S Worker Desired Cluster Size."
      hcl         = false
      key         = "worker_desired_size"
      sensitive   = false
      value       = var.worker_desired_size
    },
    {
      description = "K8S Worker Maximum Cluster Size."
      hcl         = false
      key         = "worker_max_size"
      sensitive   = false
      value       = var.worker_max_size
    },
    {
      description = "Tags to be Associated with Objects Created in Intersight."
      hcl         = true
      key         = "tags"
      sensitive   = false
      value       = var.tags_cluster
    },
  ]
}
