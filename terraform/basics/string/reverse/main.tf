terraform {
  required_version = ">= 0.13.0"
}

locals {
  strrev_output = strrev("abcdef")
}

output "strrev_output" {
  value = local.strrev_output
}
