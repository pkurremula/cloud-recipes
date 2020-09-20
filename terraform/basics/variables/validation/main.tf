terraform {
  required_version = ">= 0.13.0"
}

output "ami" {
  value = var.ami
}

output "availability_zone" {
  value = var.availability_zone
}
