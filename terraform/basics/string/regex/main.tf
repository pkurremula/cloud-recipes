terraform {
  required_version = ">= 0.13.0"
}

locals {
  regex_outputs = [
    // Return the first match only.
    regex("\\d", "123"),

    // The following pattern does not match the string. So it has been
    // deliberately commented out. It will return an error and force
    // terraform to terminate.
    // regex("\\d", "abc"),
  ]

  regexall_outputs = [
    // Return all matches as a list.
    regexall("\\d", "123"),

    // Return an empty list.
    regexall("\\d", "abc")
  ]
}

output "regex_outputs" {
  value = local.regex_outputs
}

output "regexall_outputs" {
  value = local.regexall_outputs
}
