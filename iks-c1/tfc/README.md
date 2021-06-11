# Workspace and Variable Creation

## Obtain tokens and keys

Follow the instructions to obtain values for the following variables:

## Terraform Cloud Variables

* TF_VAR_terraform_cloud_token
* TF_VAR_tfc_oath_token
* TF_VAR_tfc_organization
* TF_VAR_tfc_email
* TF_VAR_agent_pool
* TF_VAR_vcs_repo

## Intersight Variables

* TF_VAR_api_key
* TF_VAR_secret_key
* TF_VAR_vcs_repo

## Assign the vCenter Password from the Instructions

* TF_VAR_vsphere_password

## Generate an SSH Key

* TF_VAR_ssh_key

## Import the following Variables into your Environment before Running

* Terraform Cloud Variables

```bash
export TF_VAR_terraform_cloud_token="obtain_token"
export TF_VAR_tfc_oath_token="obtain_token"
export TF_VAR_tfc_organization="your_organization"
export TF_VAR_tfc_email="your_email"
export TF_VAR_agent_pool="your_agent_pool"
export TF_VAR_terraform_version="1.0.0"
export TF_VAR_vcs_repo="your_vcs_repo"
```

* Intersight Variables

```bash
export TF_VAR_organization="default"
export TF_VAR_api_key="your_api_key"
export TF_VAR_secret_key="your_secret_key"
```

* Global Variables

```bash
export TF_VAR_network_prefix="10.200.0"
export TF_VAR_domain_name="demo.intra"
export TF_VAR_dns_primary="100"
export TF_VAR_dns_secondary=""
```

* Kubernetes Policies Variables

```bash
export TF_VAR_ip_pool_gateway="254"
export TF_VAR_ip_pool_from="20"
export TF_VAR_k8s_pod_cidr="100.65.0.0"
export TF_VAR_k8s_service_cidr="100.64.0.0"
export TF_VAR_k8s_k8s_version="1.19.5"
export TF_VAR_unsigned_registries="[]"
export TF_VAR_tags_policies="[ { key = \\\"Terraform\\\", value = \\\"Module\\\" }, { key = \\\"Owner\\\", value = \\\"DevNet\\\" } ]"
```

* vSphere Variables

```bash
export TF_VAR_vsphere_target="210"
export TF_VAR_vsphere_password="your_vshpere_password"
export TF_VAR_vsphere_cluster="hx-demo"
export TF_VAR_vsphere_datastore="hx-demo-ds1"
export TF_VAR_vsphere_portgroup="Management"
export TF_VAR_vsphere_resource_pool=""
```

* Kubernetes Cluster Variables

```bash
export TF_VAR_cluster_name="sbcluster"
export TF_VAR_load_balancers="3"
export TF_VAR_ssh_user="iksadmin"
export TF_VAR_ssh_key="your_ssh_key"
export TF_VAR_master_instance_type="small"
export TF_VAR_master_desired_size="1"
export TF_VAR_master_max_size="1"
export TF_VAR_worker_instance_type="small"
export TF_VAR_worker_desired_size="0"
export TF_VAR_worker_max_size="1"
export TF_VAR_tags_cluster="[ { key = \\\"Terraform\\\", value = \\\"Module\\\" }, { key = \\\"Owner\\\", value = \\\"DevNet\\\" } ]"
```

This module will Create a Terraform Cloud Workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
