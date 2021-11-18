terraform {
  required_version = "~> 1.0.11"
}

locals {
  cidrs_string = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
  cidrs = compact(split(",", local.cidrs_string))
}

output "map_func" {
  value = local.cidrs
}
