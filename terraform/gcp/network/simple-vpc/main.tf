terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
  region  = var.region
}

resource "google_compute_network" "vpc" {
  project = var.project

  name        = var.name
  description = var.description

  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}
