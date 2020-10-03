variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "env" {
  description = "The environment associated with this module."
  type        = string
  default     = "dev"
}
