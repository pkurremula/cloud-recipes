terraform {
  required_version = ">= 0.13.0"
}

provider google {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

// --- API ---

// Enabling the Cloud Build API also creates the default service account.
resource "google_project_service" "enabled_api" {
  project = var.project
  service = "cloudbuild.googleapis.com"

  // For production system, consider assigned the below 2 properties to false.
  // Given the ephemeral nature of a recipe, we are assigning true here.
  disable_dependent_services = true
  disable_on_destroy         = true
}

// --- IAM ---

locals {
  gcb_sa     = "serviceAccount:${var.project_number}@cloudbuild.gserviceaccount.com"
  gce_sa     = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
  gcr_bucket = "artifacts.${var.project}.appspot.com"
}

// Binds role (key) to service account (value)

// Read-only access to Secret Manager.
resource "google_project_iam_binding" "secret_manager_ro" {
  role    = "roles/secretmanager.secretAccessor"
  members = [local.gcb_sa]
}

// Read/Write access to GCR (GCS bucket).
resource "google_storage_bucket_iam_binding" "gcr_rw" {
  role    = "roles/storage.admin"
  members = [local.gcb_sa]
  bucket  = local.gcr_bucket
}

// Read access to GCR (GCS bucket).
resource "google_storage_bucket_iam_binding" "gcr_ro" {
  role = "roles/storage.objectViewer"
  // If we have a GKE service account, add it here too. We allow GCE and GKE sa to
  // pull images form GCR.
  members = [local.gce_sa]
  bucket  = local.gcr_bucket
}

// --- GCB ---

resource "google_cloudbuild_trigger" "authx_master" {
  provider    = google-beta
  name        = "${var.github.owner}-${var.github.repo}-${var.github.branch}"
  description = "Trigger for push to the ${var.github.branch} branch on github.com/${var.github.owner}/${var.github.repo}"
  filename    = var.config_file
  github {
    owner = var.github.owner
    name  = var.github.repo
    push {
      // The branch value represents a regex expression. Enclose with ^$ for an exact match.
      branch = "^${var.github.branch}$"
    }
  }
}

