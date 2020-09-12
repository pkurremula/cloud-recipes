terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  region  = var.region
  version = "~> 3.38.0"
  project = var.project
}

locals {
  startup_script_file = "startup.sh"
}

// Image

data "google_compute_image" "os" {
  project = "centos-cloud"
  family  = "centos-7"
}

// Firewall rules.

resource "google_compute_firewall" "http" {
  name = "http-fw"
  network = google_compute_instance.host.network_interface[0].network

  allow {
    protocol = "tcp"
    ports = ["80", "443", var.port]
  }

  source_ranges = ["0.0.0.0/0"]
  direction = "INGRESS"

  depends_on = [google_compute_instance.host]
}

// Create a GCE instance.

resource "google_compute_instance" "host" {
  machine_type = var.instance_type
  name         = "cloud-recipes-startup-vm"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.os.self_link
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  // For terraform 0.12 and above, use the function templatefile instead of
  // data.template_file.
  metadata_startup_script = templatefile("${path.module}/${local.startup_script_file}", {
    port         = var.port
    node_version = var.node_version
  })
}
