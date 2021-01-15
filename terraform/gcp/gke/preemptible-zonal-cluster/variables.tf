variable "region" {
  description = "The GCE region."
  type        = string
  default     = "us-west1"
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "zone" {
  description = "The zone where this GKE cluster is located."
  type        = string
  default     = "us-west1-c"
}

variable "prefix" {
  description = "Name prefix for this module."
  type        = string
  default     = "exp"
}

variable "env" {
  description = "The environment associated with this module."
  type        = string
  default     = "exp"
}

variable "machine_type" {
  description = "The machine type in this GKE cluster."
  type        = string
  default     = "e2-small"
}

variable "disk_size" {
  description = "The size (GB) of the disk attached to each node."
  type        = number
  default     = 10
}

variable "min_node_count" {
  description = "The minimum number of nodes in the pool."
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "The maximum number of nodes in the pool."
  type        = number
  default     = 9
}
