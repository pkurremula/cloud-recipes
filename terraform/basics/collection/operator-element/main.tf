terraform {
  required_version = ">= 0.13.0"
}

locals {
  numbers = [0, 1, 2, 3, 4]
}

data "null_data_source" "element" {
  // Deliberately increase the size of count so that we have an index that
  // goes out of bound. The function element handles out-of-bound index by
  // wrapping around
  count = length(local.numbers) * 2

  inputs = {
    items = element(local.numbers, count.index)
  }
}

data "null_data_source" "operator" {
  // No wrap around support with the [] operator
  count = length(local.numbers)

  inputs = {
    items = local.numbers[count.index]
  }
}

output "element" {
  value = data.null_data_source.element[*].inputs.items
}

output "operator" {
  value = data.null_data_source.operator[*].inputs.items
}
