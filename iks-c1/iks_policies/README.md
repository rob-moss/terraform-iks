# IKS Policies Module

## Use this module to create Kubernetes polices in Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.8 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ip_pool"></a> [ip\_pool](#module\_ip\_pool) | terraform-cisco-modules/iks/intersight//modules/ip_pool | n/a |
| <a name="module_k8s_instance_large"></a> [k8s\_instance\_large](#module\_k8s\_instance\_large) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_instance_medium"></a> [k8s\_instance\_medium](#module\_k8s\_instance\_medium) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_instance_small"></a> [k8s\_instance\_small](#module\_k8s\_instance\_small) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#module\_k8s\_trusted\_registry) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | n/a |
| <a name="module_k8s_version_policy"></a> [k8s\_version\_policy](#module\_k8s\_version\_policy) | terraform-cisco-modules/iks/intersight//modules/version | n/a |
| <a name="module_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#module\_k8s\_vm\_infra\_policy) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | n/a |
| <a name="module_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#module\_k8s\_vm\_network\_policy) | terraform-cisco-modules/iks/intersight//modules/k8s_network | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.organization](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.8/docs/data-sources/organization_organization) | data source |
| [terraform_remote_state.global](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_cni"></a> [cni](#input\_cni) | Supported CNI type. Currently we only support Calico.<br>* Calico - Calico CNI plugin as described in:<br> https://github.com/projectcalico/cni-plugin | `string` | `"Calico"` | no |
| <a name="input_k8s_pod_cidr"></a> [k8s\_pod\_cidr](#input\_k8s\_pod\_cidr) | Pod CIDR Block to be used to assign Pod IP Addresses. | `string` | `"100.65.0.0/64"` | no |
| <a name="input_k8s_service_cidr"></a> [k8s\_service\_cidr](#input\_k8s\_service\_cidr) | Service CIDR Block used to assign Cluster Service IP Addresses. | `string` | `"100.64.0.0/64"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes Version to Deploy. | `string` | `"1.19.5"` | no |
| <a name="input_root_ca_registries"></a> [root\_ca\_registries](#input\_root\_ca\_registries) | List of root CA Signed Registries. | `list(string)` | `[]` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization. | `string` | `"DevNet"` | no |
| <a name="input_unsigned_registries"></a> [unsigned\_registries](#input\_unsigned\_registries) | List of unsigned registries to be supported. | `list(string)` | `[]` | no |
| <a name="input_vsphere_cluster"></a> [vsphere\_cluster](#input\_vsphere\_cluster) | vSphere Cluster to assign the K8S Cluster Deployment. | `string` | `"hx-demo"` | no |
| <a name="input_vsphere_datastore"></a> [vsphere\_datastore](#input\_vsphere\_datastore) | vSphere Datastore to assign the K8S Cluster Deployment. | `string` | `"hx-demo-ds1"` | no |
| <a name="input_vsphere_password"></a> [vsphere\_password](#input\_vsphere\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_vsphere_portgroup"></a> [vsphere\_portgroup](#input\_vsphere\_portgroup) | vSphere Port Group to assign the K8S Cluster Deployment. | `list` | <pre>[<br>  "Management"<br>]</pre> | no |
| <a name="input_vsphere_resource_pool"></a> [vsphere\_resource\_pool](#input\_vsphere\_resource\_pool) | vSphere Resource Pool to assign the K8S Cluster Deployment. | `string` | `""` | no |
| <a name="input_ws_global_vars"></a> [ws\_global\_vars](#input\_ws\_global\_vars) | Global Variable Workspace Name | `string` | `"global_vars"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_pool"></a> [ip\_pool](#output\_ip\_pool) | ----------------------------- Kubernetes Policies Outputs ----------------------------- |
| <a name="output_k8s_instance_large"></a> [k8s\_instance\_large](#output\_k8s\_instance\_large) | n/a |
| <a name="output_k8s_instance_medium"></a> [k8s\_instance\_medium](#output\_k8s\_instance\_medium) | n/a |
| <a name="output_k8s_instance_small"></a> [k8s\_instance\_small](#output\_k8s\_instance\_small) | ----------------------------- Kubernetes Policies Outputs ----------------------------- |
| <a name="output_k8s_network_cidr"></a> [k8s\_network\_cidr](#output\_k8s\_network\_cidr) | n/a |
| <a name="output_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#output\_k8s\_nodeos\_config) | n/a |
| <a name="output_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#output\_k8s\_trusted\_registry) | n/a |
| <a name="output_k8s_version_policy"></a> [k8s\_version\_policy](#output\_k8s\_version\_policy) | n/a |
| <a name="output_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#output\_k8s\_vm\_infra\_policy) | n/a |
| <a name="output_organization"></a> [organization](#output\_organization) | ------------------------- Intersight Organization ------------------------- |
| <a name="output_organization_moid"></a> [organization\_moid](#output\_organization\_moid) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
