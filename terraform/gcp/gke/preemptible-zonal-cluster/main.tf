terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

// This module relies on a custom network module that creates a GKE network.
module "network" {
  source = "../../network/gke-network"

  project = var.project
  region  = var.region
  prefix  = var.prefix
  env     = var.env
}

// We need to enable service:container.googleapis.com to generate a service account needed
// by GKE.
resource "google_project_service" "container_api" {
  project = var.project
  service = "container.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_container_cluster" "default" {
  # For zonal cluster assign a zone to the location.
  name     = "${var.prefix}-gke"
  project  = var.project
  location = var.zone

  network    = module.network.vpc_self_link
  subnetwork = module.network.gke_subnet.self_link

  depends_on = [
    google_service_account.gke_sa
  ]

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"

  initial_node_count       = 1
  remove_default_node_pool = true

  node_config {
    service_account = google_service_account.gke_sa.email
  }

  lifecycle {
    ignore_changes = [
      node_config
    ]
  }
}

resource "google_container_node_pool" "pool" {
  project            = var.project
  name               = "${var.prefix}-pool"
  cluster            = google_container_cluster.default.name
  initial_node_count = var.min_node_count
  location           = var.zone

  autoscaling {
    max_node_count = var.max_node_count
    min_node_count = var.min_node_count
  }

  node_config {
    preemptible     = true
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size
    service_account = google_service_account.gke_sa.email
  }

  depends_on = [
    google_service_account.gke_sa
  ]

  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_config,
    ]
  }
}
