terraform {
  required_version = ">= 1.0.11"
}

locals {
  map_literal = {
    "Name" = "map_literal"
    "Terraform" = true
    "Count" = 2
  }
  map_func = tomap(local.map_literal) # This will convert all the fields in map_literal to string type.

  terraform = lookup(local.map_literal, "Terraform")
  name = lookup(local.map_literal, "Name")
}

output "map_func" {
  value = local.map_func
}

output "map_literal" {
  value = local.map_literal
}

output "terraform" {
  value = local.terraform
}

output "name" {
  value = local.name
}
