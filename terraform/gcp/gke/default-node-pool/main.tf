terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

module "network" {
  source = "../../network/gke-network"

  project = var.project
  region  = var.region
  prefix  = var.gke.prefix
  env     = var.gke.env
}

// We need to enable service:container.googleapis.com to generate a service account needed
// by GKE.
resource "google_project_service" "container-api" {
  project = var.project
  service = "container.googleapis.com"
}

resource "google_container_cluster" "default" {
  name               = "${var.gke.prefix}-gke"
  location           = var.region
  initial_node_count = 1

  network            = module.network.vpc_self_link
  subnetwork         = module.network.gke_subnet.self_link
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  node_config {
    machine_type = var.gke.machine_type
    disk_size_gb = var.gke.disk_size
  }
}
