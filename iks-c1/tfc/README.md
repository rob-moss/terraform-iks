# Terraform Cloud - Workspace Module

## Usage

```hcl
module "tfc_workspaces" {

  source = "terraform-cloud//modules/tfc_workspaces"

  # omitted...
}
```

This module will Create a Terraform Cloud Workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.25.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfc_agent_pool"></a> [tfc\_agent\_pool](#module\_tfc\_agent\_pool) | ../modules/tfc_agent_pool | n/a |
| <a name="module_tfc_variables_ACI"></a> [tfc\_variables\_ACI](#module\_tfc\_variables\_ACI) | ../modules/tfc_variables | n/a |
| <a name="module_tfc_variables_IKS"></a> [tfc\_variables\_IKS](#module\_tfc\_variables\_IKS) | ../modules/tfc_variables | n/a |
| <a name="module_tfc_workspaces"></a> [tfc\_workspaces](#module\_tfc\_workspaces) | ../modules/tfc_workspaces | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool"></a> [agent\_pool](#input\_agent\_pool) | Terraform Cloud Agent Pool | `string` | n/a | yes |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | API Key | `string` | n/a | yes |
| <a name="input_apicPass"></a> [apicPass](#input\_apicPass) | APIC Password | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Secret Key or file location | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH Public Key to be used to node login. | `string` | n/a | yes |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud | `string` | n/a | yes |
| <a name="input_tfc_oath_token"></a> [tfc\_oath\_token](#input\_tfc\_oath\_token) | Terraform Cloud OAuth Token for VCS\_Repo Integration | `string` | n/a | yes |
| <a name="input_tfc_org_name"></a> [tfc\_org\_name](#input\_tfc\_org\_name) | Terraform Cloud Organization Name | `string` | n/a | yes |
| <a name="input_vc_password"></a> [vc\_password](#input\_vc\_password) | Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | n/a |
| <a name="output_tfc_workspaces"></a> [tfc\_workspaces](#output\_tfc\_workspaces) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
