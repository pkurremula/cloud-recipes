terraform {
  required_version = ">= 0.13.0"
}

locals {
  servers = ["darnassus", "darkshire", "undercity"]

  format_output = format("Created %d instances of %s", 3, "api-server")
  formatlist_output = formatlist("Created %d instances of %s: %s", 3, "api-server", local.servers)
  lower_output = lower("CREATED 3 Instances in subnet 10.10.0.1")
  upper_output = upper("CREATED 3 Instances in subnet 10.10.0.1")
  title_output = title("CREATED 3 Instances in subnet 10.10.0.1")
}

output "format_output" {
  value = local.format_output
}

output "formatlist_output" {
  value = local.formatlist_output
}

output "lower_output" {
  value = local.lower_output
}

output "upper_output" {
  value = local.upper_output
}

output "title_output" {
  value = local.title_output
}
