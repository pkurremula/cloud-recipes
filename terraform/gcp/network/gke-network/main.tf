terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

locals {
  vpc_name                      = "${var.prefix}-vpc"
  pods_secondary_range_name     = "${var.prefix}-sec-range-gke-pods"
  services_secondary_range_name = "${var.prefix}-sec-range-gke-services"
}

// --- VPC ---

resource "google_compute_network" "vpc" {
  project                 = var.project
  name                    = local.vpc_name
  description             = "VPC for GKE."
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

// --- Subnet ---

resource "google_compute_subnetwork" "primary" {
  project = var.project
  region  = var.region
  network = google_compute_network.vpc.self_link

  name                     = "${var.prefix}-subnet-primary"
  description              = "Primary subnet for VPC ${local.vpc_name}."
  ip_cidr_range            = "10.0.0.0/20"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "gke" {
  project = var.project
  region  = var.region
  network = google_compute_network.vpc.self_link

  name                     = "${var.prefix}-subnet-gke"
  description              = "GKE subnet for VPC ${local.vpc_name}."
  ip_cidr_range            = "10.1.0.0/20"
  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name    = local.pods_secondary_range_name
      ip_cidr_range = "10.18.0.0/16"
    },
    {
      range_name    = local.services_secondary_range_name
      ip_cidr_range = "10.19.0.0/16"
    },
  ]
}

// --- NAT ---

resource "google_compute_router" "this" {
  name    = "${var.prefix}-router"
  network = google_compute_network.vpc.self_link
}

resource "google_compute_router_nat" "this" {
  name                   = "${var.prefix}-nat"
  router                 = google_compute_router.this.name
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.primary.id
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
  }

  subnetwork {
    name = google_compute_subnetwork.gke.id
    source_ip_ranges_to_nat = [
      "PRIMARY_IP_RANGE",
      "LIST_OF_SECONDARY_IP_RANGES",
    ]
    secondary_ip_range_names = [
      local.pods_secondary_range_name,
      local.services_secondary_range_name,
    ]
  }
}
