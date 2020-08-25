terraform {
  required_version = ">= 0.13.0"
}

locals {
  // "subnet-fe8467ab" and "subnet-635fa38b" are repeated.
  subnet_ids = ["", "subnet-635fa38b", "subnet-fe8467ab", "subnet-fe8467ab", "", "subnet-bbc37f00", "subnet-635fa38b"]
  clean_ids  = distinct(compact(local.subnet_ids))

  // Works with numbers too. Function compact will just convert the list to a list of stirngs.
  numbers          = [0, 1, 2, 3, 3, 4, 4, 4, 5]
  distinct_numbers = distinct(compact(local.numbers))
}

output "clean_ids" {
  value = local.clean_ids
}

output "distinct_numbers" {
  value = local.distinct_numbers
}
