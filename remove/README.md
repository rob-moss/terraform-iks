# Remove Intersight Kubernetes Service Workspace

## Use this module to Destroy the IKS Cluster

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

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_kubernetes_cluster_profile.delete](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.8/docs/resources/kubernetes_cluster_profile) | resource |
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.8/docs/data-sources/organization_organization) | data source |
| [terraform_remote_state.global](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization. | `string` | `"CiscoDevNet"` | no |
| <a name="input_ws_global_vars"></a> [ws\_global\_vars](#input\_ws\_global\_vars) | Global Variables Workspace Name.  The default value will be set to {cluster\_name}\_global\_vars by the tfe variable module. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
