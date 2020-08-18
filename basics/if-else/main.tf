terraform {
  required_version = ">= 0.12.29"
}

locals {
  print_name = true
  print_descriptor = false
}

data "null_data_source" "name" {
  // Basically the if-else statement.
  count = local.print_name ? 1 : 0
  inputs = {
    name = "Joe"
  }
}

data "null_data_source" "age" {
  // Basically a if-else statement.
  count = local.print_descriptor ? 1 : 0
  inputs = {
    age = 35
  }
}

output "name" {
  value = data.null_data_source.name[*].outputs.name
}

output "age" {
  // Because the null_data_source resource has `count` set, its attributes must be accessed on specific instances.
  // In other words, we need to call the following to return a value:
  //
  // data.null_data_source.age[*].outputs.age
  //
  // But because count is set to 0, the call returns an empty list.
  value = data.null_data_source.age[*].outputs.age
}
