terraform {
  required_version = ">= 0.12.29"
}

locals {
  chomp_outputs = [
    chomp("terraform"),
    chomp("terraform\r"),
    chomp("terraform\n"),
    chomp("terraform\r\n"),
    chomp("terraform\n\n"),
  ]

  trim_outputs = [
    trim("terraform", ""),
    trim("terraform123", "123"),
    trim("terraform321", "123"),
    trim("terraform123", "321"),
    trim("321terraform123", "123"),
    trim("terra123form", "123"),  // Only the start and end of the string.
  ]

  trimsuffix_outputs = [
    trimsuffix("terraform", ""),
    trimsuffix("terraform123", "123"),
    trimsuffix("terraform321", "123"),  // Removal of substring, not set of characters.
    trimsuffix("123terraform", "123"),  // Works on suffix.
  ]

  trimprefix_outputs = [
    trimprefix("terraform", ""),
    trimprefix("123terraform", "123"),
    trimprefix("321terraform", "123"),  // Removal of substring, not set of characters.
    trimprefix("terraform123", "123"),  // Works on prefix.
  ]
}

output "chomp_outputs" {
  value = local.chomp_outputs
}

output "trim_outputs" {
  value = local.trim_outputs
}

output "trimsuffix_outputs" {
  value = local.trimsuffix_outputs
}

output "trimprefix_outputs" {
  value = local.trimprefix_outputs
}
