terraform {
  required_version = ">= 0.13.0"
}

locals {
  countries = ["us", "jp", "ch", "cn", "uk", "sg"]
}

output "uppercase" {
  // We can't embed the `for` loop in the a block or resource. It can only be used in
  // a list or map.
  value = [for country in local.countries : upper(country)]
}

output "uppercase_if" {
  // You can use the if expression in the for block. Returns countries that starts with 'c'.
  value = [for country in local.countries : upper(country) if length(regexall("^c", country)) > 0]
}
