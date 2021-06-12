# Sample App Workspace

## Use this module to create the Kubernetes sample application through Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.8 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_ws_name"></a> [iks\_ws\_name](#input\_iks\_ws\_name) | Intersight Kubernetes Service (IKS) Workspace Name | `string` | `"iks"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Intersight Secret Key. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
