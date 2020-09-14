variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "name" {
  description = "Name of the GCE instance."
  type        = string
  default     = "cloud-recipes-vm"
}

variable "description" {
  description = "The description fo the GCE instance."
  type        = string
  default     = "Cloud recipe"
}

// See https://cloud.google.com/compute/docs/images/os-details
variable "image_name" {
  description = "The image name for the GCE instance."
  type        = string
  default     = "debian-cloud/debian-9"
}

variable "instance_type" {
  description = "The instance type for the GCE instance."
  type        = string
  default     = "e2-micro"
}
