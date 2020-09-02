terraform {
  required_version = ">= 0.13.0"
}

output "booleans" {
  value = var.booleans
}

output "numbers" {
  value = var.numbers
}

output "strings" {
  value = var.strings
}

output "network_object" {
  value = var.network_object
}

output "network_map" {
  value = var.network_map
}

output "list_values" {
  value = var.list_values
}

output "tuple_values" {
  value = var.tuple_values
}
