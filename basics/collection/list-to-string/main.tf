terraform {
  required_version = ">= 0.12.29"
}

locals {
  cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24",]
  cidrs_string = join(",", local.cidrs)
}

output "map_func" {
  value = local.cidrs_string
}
