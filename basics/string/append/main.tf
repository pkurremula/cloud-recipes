terraform {
  required_version = ">= 0.12.29"
}

locals {
  append_format = format("Hello %s, welcome to the year %d!", "John", 2020)

  append_join = join("", ["Hello", " John", ", welcome to the year", " 2020", "!"])
}

output "combined_format" {
  value = local.append_format
}

output "combined_join" {
  value = local.append_join
}

