# IKS Cluster Module

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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_profile"></a> [control\_profile](#module\_control\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/iks/intersight//modules/cluster | n/a |
| <a name="module_master_instance_type"></a> [master\_instance\_type](#module\_master\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_worker_instance_type"></a> [worker\_instance\_type](#module\_worker\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.global](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.iks_policies](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_global_vars_ws"></a> [global\_vars\_ws](#input\_global\_vars\_ws) | Global Variables Workspace Name. | `string` | `"global_vars"` | no |
| <a name="input_iks_policy_ws"></a> [iks\_policy\_ws](#input\_iks\_policy\_ws) | Intersight Kubernetes Service Policies Workspace. | `string` | `"iks_policies"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | Intersight Kubernetes Load Balancer count. | `string` | `3` | no |
| <a name="input_master_desired_size"></a> [master\_desired\_size](#input\_master\_desired\_size) | K8S Master Desired Cluster Size. | `string` | `1` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | K8S Master Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_master_max_size"></a> [master\_max\_size](#input\_master\_max\_size) | K8S Master Maximum Cluster Size. | `string` | `1` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Intersight Kubernetes Service Cluster SSH Public Key. | `string` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | Intersight Kubernetes Service Cluster Default User. | `string` | `"iksadmin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization. | `string` | `"DevNet"` | no |
| <a name="input_worker_desired_size"></a> [worker\_desired\_size](#input\_worker\_desired\_size) | K8S Worker Desired Cluster Size. | `string` | `0` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | K8S Worker Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_worker_max_size"></a> [worker\_max\_size](#input\_worker\_max\_size) | K8S Worker Maximum Cluster Size. | `string` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubernetes Configuration File. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
