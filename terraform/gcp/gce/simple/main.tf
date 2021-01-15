terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

// --- API ---

// Enabling the Cloud Build API also creates the default service account.
resource "google_project_service" "enabled_api" {
  project = var.project
  service = "compute.googleapis.com"

  // For production system, consider assigned the below 2 properties to false.
  // Given the ephemeral nature of a recipe, we are assigning true here.
  disable_dependent_services = true
  disable_on_destroy         = true
}

// --- GCE ---

resource "google_compute_instance" "host" {
  name         = var.vm.name
  description  = var.vm.description
  machine_type = var.vm.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.vm.image_name
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
