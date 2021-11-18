terraform {
  required_version = "~> 1.0.11"
}

locals {
  list1 = ["a", "b", "c"]
  list2 = ["c", "e", "f"]
  joined_list = flatten([local.list1, local.list2])  # Need to be list of lists.
}

output "map_func" {
  value = local.joined_list   # Output: ["a", "b", "c", "c", "e", "f"]
}
