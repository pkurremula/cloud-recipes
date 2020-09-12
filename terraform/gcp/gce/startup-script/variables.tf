variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the GCE instance."
  type        = string
  default     = "e2-micro"
}

variable "port" {
  description = "The TCP port of the application server."
  type        = number
  default     = 8080
}

variable "node_version" {
  description = "The version of node.js to instll."
  type        = string
  default     = "v12.13.0"
}
