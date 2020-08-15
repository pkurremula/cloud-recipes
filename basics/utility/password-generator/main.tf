terraform {
  required_version = ">= 0.12.29"
}

resource "random_password" "password" {
  length           = 24
  special          = true
  number           = true
  upper            = true
  lower            = true
  override_special = "-_=!<>^"
  min_special      = 3
}

output "password" {
  description = "The randomly generated password."
  value       = random_password.password.result
}
