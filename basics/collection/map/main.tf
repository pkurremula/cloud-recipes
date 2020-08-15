terraform {
  required_version = ">= 0.12.29"
}

locals {
  map_func = map("Name", "map_func", "Terraform", true, "Count", 3)
  map_literal = {
    "Name" = "map_literal"
    "Terraform" = true
    "Count" = 2
  }
}

output "map_func" {
  value = local.map_func
}

output "map_literal" {
  value = local.map_literal
}
