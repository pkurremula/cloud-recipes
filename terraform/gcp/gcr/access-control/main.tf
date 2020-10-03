terraform {
  required_version = ">= 0.13.0"
}

provider "google" {
  version = "~> 3.38.0"
  project = var.project
}

// --- IAM ---

// Assume that we have GKE with a service account that pulls images from this GCR.
resource "google_service_account" "gke" {
  project      = var.project
  account_id   = "${var.env}-gke-sa"
  display_name = "Service Account for GKE ${var.env} environment."
}

// Grant GKE service account read access to GCR.
resource "google_storage_bucket_iam_binding" "admin" {
  bucket = google_container_registry.default.id

  // For details on ACL, see https://cloud.google.com/container-registry/docs/access-control
  role = "roles/storage.objectViewer"
  members = [
    // Don't forget to prefix it with 'serviceAccount:'.
    "serviceAccount:${google_service_account.gke.email}"
  ]
}

// --- GCR ---

resource "google_container_registry" "default" {
  project = var.project
}
