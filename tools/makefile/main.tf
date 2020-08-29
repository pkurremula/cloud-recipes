terraform {
  required_version = ">= 0.13.0"
}

locals {
  greetings = "Hello world"
}

data "null_data_source" "this" {
  inputs = {
    upper_greetings = upper(local.greetings)
  }
}

output "uppercase" {
  value = data.null_data_source.this.outputs.upper_greetings
}
