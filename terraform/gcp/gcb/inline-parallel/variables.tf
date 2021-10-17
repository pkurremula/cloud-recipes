variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "github" {
  description = "Configurations for Github repository."
  type = map
  default = {
    owner  = "my-github-handle"
    repo   = "my-repo"
    branch = "master"
  }
}
