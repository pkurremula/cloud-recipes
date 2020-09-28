variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "prefix" {
  description = "Name prefix for this module."
  type        = string
}

variable "env" {
  description = "The environment associated with this module."
  type        = string
  default     = ""
}

