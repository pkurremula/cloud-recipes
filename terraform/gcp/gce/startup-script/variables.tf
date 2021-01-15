variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable vm {
  description = "Configurations for the VM instance."
  type        = map
  default = {
    name         = "cloud-recipes-vm"
    description  = "Cloud recipe: GCE instance with startup script."
    machine_type = "e2-micro"
    port         = 8080
    node_version = "v12.13.0"
  }
}
