terraform {
  required_version = ">= 0.13.0"
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

data "null_data_source" "foreach_if" {
  // Return countries that starts with c.
  for_each = {
    for key, country in toset(local.countries) :
      key => upper(country) if length(regexall("^c", country)) > 0
  }

  inputs = {
    countries = upper(each.value)
  }
}

output "uppercase" {
  // foreach returns a map of maps. Use the values function to convert to a list.
  value = values(data.null_data_source.foreach)[*].outputs.countries
}

output "uppercase_if" {
  // foreach returns a map of maps. Use the values function to convert to a list.
  value = values(data.null_data_source.foreach_if)[*].outputs.countries
}
