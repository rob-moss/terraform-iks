# Global Variables Workspace

## Use this module to create Global Variales consumed by the IKS workspaces

Run the plan from the Terraform cloud workspace for the Given Workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Intersight Kubernetes Service Cluster Name. | `string` | `"iks"` | no |
| <a name="input_dns_primary"></a> [dns\_primary](#input\_dns\_primary) | Primary DNS Server for Kubernetes Sysconfig Policy. If Using DevNet Sandbox default is {network\_prefix}.100 | `string` | `"100"` | no |
| <a name="input_dns_secondary"></a> [dns\_secondary](#input\_dns\_secondary) | Secondary DNS Server for Kubernetes Sysconfig Policy. | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name for Kubernetes Sysconfig Policy. | `string` | `"demo.intra"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL | `string` | `"https://intersight.com"` | no |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | Intersight Kubernetes Service IP Pool.  Default name is {cluster\_name}\_ip\_pool | `string` | `""` | no |
| <a name="input_ip_pool_from"></a> [ip\_pool\_from](#input\_ip\_pool\_from) | IP Pool Starting IP last Octet.  The var.network\_prefix will be combined with ip\_pool\_from for the Gateway Address. | `string` | `"20"` | no |
| <a name="input_ip_pool_gateway"></a> [ip\_pool\_gateway](#input\_ip\_pool\_gateway) | IP Pool Gateway last Octet.  The var.network\_prefix will be combined with ip\_pool\_gateway for the Gateway Address. | `string` | `"254"` | no |
| <a name="input_ip_pool_netmask"></a> [ip\_pool\_netmask](#input\_ip\_pool\_netmask) | IP Pool Netmask. | `string` | `"255.255.255.0"` | no |
| <a name="input_ip_pool_size"></a> [ip\_pool\_size](#input\_ip\_pool\_size) | IP Pool Block Size. | `string` | `"30"` | no |
| <a name="input_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#input\_k8s\_trusted\_registry) | Kubernetes Trusted Registry Policy Name.  Default name is {cluster\_name}-registry. | `string` | `""` | no |
| <a name="input_k8s_version_policy"></a> [k8s\_version\_policy](#input\_k8s\_version\_policy) | Kubernetes Version Policy Name.  Default name is {cluster\_name}-k8s-version. | `string` | `""` | no |
| <a name="input_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#input\_k8s\_vm\_infra\_policy) | Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster\_name}-vm-infra-config. | `string` | `""` | no |
| <a name="input_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#input\_k8s\_vm\_network\_policy) | Kubernetes Network/System Configuration Policy (CIDR, dns, ntp, etc.).  Default name is {cluster\_name}-sysconfig. | `string` | `""` | no |
| <a name="input_network_prefix"></a> [network\_prefix](#input\_network\_prefix) | Network Prefix to Assign to DNS/NTP Servers & vCenter Target default values. | `string` | `"10.200.0"` | no |
| <a name="input_ntp_primary"></a> [ntp\_primary](#input\_ntp\_primary) | Primary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns\_primary. | `string` | `""` | no |
| <a name="input_ntp_secondary"></a> [ntp\_secondary](#input\_ntp\_secondary) | Secondary NTP Server for Kubernetes Sysconfig Policy.  Default value is the variable dns\_secondary. | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization. | `string` | `"default"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for Kubernetes Sysconfig Policy. | `string` | `"America/New_York"` | no |
| <a name="input_vsphere_target"></a> [vsphere\_target](#input\_vsphere\_target) | vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox. | `string` | `"210"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_dns_primary"></a> [dns\_primary](#output\_dns\_primary) | n/a |
| <a name="output_dns_secondary"></a> [dns\_secondary](#output\_dns\_secondary) | n/a |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_ip_pool"></a> [ip\_pool](#output\_ip\_pool) | n/a |
| <a name="output_ip_pool_from"></a> [ip\_pool\_from](#output\_ip\_pool\_from) | n/a |
| <a name="output_ip_pool_gateway"></a> [ip\_pool\_gateway](#output\_ip\_pool\_gateway) | n/a |
| <a name="output_ip_pool_netmask"></a> [ip\_pool\_netmask](#output\_ip\_pool\_netmask) | n/a |
| <a name="output_ip_pool_size"></a> [ip\_pool\_size](#output\_ip\_pool\_size) | n/a |
| <a name="output_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#output\_k8s\_trusted\_registry) | n/a |
| <a name="output_k8s_version_policy"></a> [k8s\_version\_policy](#output\_k8s\_version\_policy) | n/a |
| <a name="output_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#output\_k8s\_vm\_infra\_policy) | n/a |
| <a name="output_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#output\_k8s\_vm\_network\_policy) | n/a |
| <a name="output_ntp_primary"></a> [ntp\_primary](#output\_ntp\_primary) | n/a |
| <a name="output_ntp_secondary"></a> [ntp\_secondary](#output\_ntp\_secondary) | n/a |
| <a name="output_organization"></a> [organization](#output\_organization) | n/a |
| <a name="output_timezone"></a> [timezone](#output\_timezone) | n/a |
| <a name="output_vsphere_target"></a> [vsphere\_target](#output\_vsphere\_target) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
