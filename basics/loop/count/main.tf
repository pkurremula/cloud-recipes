terraform {
  required_version = ">= 0.12.29"
}

locals {
  countries = ["us", "jp", "ch", "cn", "uk", "sg"]
}

data "null_data_source" "count" {
  count = length(local.countries)
  inputs = {
    countries = upper(local.countries[count.index])
  }
}

output "uppercase" {
  value = data.null_data_source.count[*].outputs.countries
}
