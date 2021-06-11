variable "dns_primary" {
  default = "10.101.128.15"
}

variable "dns_secondary" {
  default = "10.101.128.15"
}

output "dns_servers" {
  value = [
    var.dns_primary,
    trimspace(<<-EOT
    %{if var.dns_secondary != ""~}${var.dns_secondary}%{endif~}
    EOT
    )
  ]
}
