terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

locals {
  startup_script_file = "startup.sh"
  vm_firewall_tag     = "http"
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

// Image

data "google_compute_image" "os" {
  project = "centos-cloud"
  family  = "centos-7"
}

// Firewall rules.

data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_firewall" "http" {
  name    = "allow-http-fw"
  network = google_compute_instance.host.network_interface[0].network

  allow {
    protocol = "tcp"
    ports    = ["80", "443", var.vm.port]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"

  source_tags = [local.vm_firewall_tag]
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
  name         = var.vm.name
  description  = var.vm.description
  machine_type = var.vm.machine_type
  // Use function element handles out-of-bound index by wrapping around.
  zone = element(data.google_compute_zones.available.names, local.index)

  boot_disk {
    initialize_params {
      image = data.google_compute_image.os.self_link
      type  = "pd-standard"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link

    access_config {
      // Ephemeral IP
    }
  }

  // For terraform 0.12 and above, use the function templatefile instead of
  // data.template_file.
  metadata_startup_script = templatefile("${path.module}/${local.startup_script_file}", {
    port         = var.vm.port
    node_version = var.vm.node_version
  })

  // Although not necessary, we use tags to associate the firewall rules to a vm instance.
  tags = [local.vm_firewall_tag]
}
