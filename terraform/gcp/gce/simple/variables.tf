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
    description  = "Cloud recipe: simple GCE instance."
    image_name   = "debian-cloud/debian-9" // See https://cloud.google.com/compute/docs/images/os-details
    machine_type = "e2-micro"
  }
}
