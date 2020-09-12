terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  region  = var.region
  version = "~> 3.38.0"
  project = var.project
}

// Select a random zone from the specified region.
// All this work because we must specify a zone in GCE, so we randomly select a zone.
// NOTE: We can also keep it super simple and just assign zone = "${var.region}-a".

data "google_compute_zones" "available" {}

resource "random_integer" "index" {
  // Don't worry about out of bound, Terraform will wrap the index back to 0.
  max = length(data.google_compute_zones.available.names)
  min = 0
}

locals {
  index = random_integer.index.result
}

// Create a GCE instance.

resource "google_compute_instance" "host" {
  machine_type = var.instance_type
  name         = "cloud-recipes-simple-vm"
  zone         = data.google_compute_zones.available.names[local.index]

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
