resource "google_service_account" "gke_sa" {
  project = var.project
  account_id = "${var.prefix}-gke-sa"
  display_name = "${var.prefix}-gke-sa"
}

# Grant sa write access to monitoring policy.
resource "google_project_iam_member" "gke_sa_monitoring_editor_policy" {
  project = var.project
  role    = "roles/monitoring.editor"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Grant sa write access to logging policy.
resource "google_project_iam_member" "gke_sa_log_writer_policy" {
  project = var.project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}
