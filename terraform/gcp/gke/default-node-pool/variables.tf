variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "gke" {
  description = "GKE configuration."
  type        = map
  default = {
    prefix       = "dev"
    env          = "dev"
    machine_type = "g1-small"
    disk_size    = 10
  }
}
