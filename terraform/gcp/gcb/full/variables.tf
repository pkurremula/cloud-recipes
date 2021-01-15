variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project_number" {
  description = "The project number. This is needed for the creation of service account."
  type        = string
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "config_file" {
  description = "The config file describing GCB pipeline."
  type        = string
  default     = "cloudbuild/default.yaml"
}

variable "github" {
  type = map
  default = {
    owner  = "cybersamx"
    repo   = "authx"
    branch = "master"
  }
}
