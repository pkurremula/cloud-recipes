variable "region" {
  description = "The GCP region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "gke" {
  description = "Configurations for the GKE cluster."
  type        = map
  default = {
    prefix         = "dev"
    zone           = "us-west1-c"
    env            = "dev"
    machine_type   = "e2-small"
    disk_size      = 10
    min_node_count = 1
    max_node_count = 9
  }
}
