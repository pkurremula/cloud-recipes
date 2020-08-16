terraform {
  required_version = ">= 0.12.29"
}

locals {
  countries = {
    us = {
      name = "USA"
      population = 331002651
    },
    jp = {
      name = "Japan"
      population = 126476461
    },
    ch = {
      name = "Switzerland"
      population = 8654622
    },
    cn = {
      name = "China"
      population = 1439323776
    },
    uk = {
      name = "United Kingdom"
      population = 67886011
    },
    sg = {
      name = "Singapore"
      population = 5850342
    }
  }
}

output "lowercase" {
  value = {for key, country in local.countries : key => lower(country.name)}
}

output "lowercase_if" {
  // Returns countries with population > 100M.
  value = {for key, country in local.countries : key => lower(country.name) if country.population > 100000000}
}
