terraform {
  required_version = ">= 0.12.29"
}

locals {
  countries = ["us", "jp", "ch", "cn", "uk", "sg"]
}

data "null_data_source" "foreach" {
  // `for_each` operates on a map or set of strings. As such the result of
  // `for_each` is not in the same order of the input.
  for_each = toset(local.countries)
  inputs = {
    countries = upper(each.value)
  }
}

output "uppercase" {
  // foreach returns a map of maps. Use the values function to convert to a list.
  value = values(data.null_data_source.foreach)[*].outputs.countries
}
