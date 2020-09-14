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
  description = "Name of the VPC."
  type        = string
  default     = "cloud-recipes-vpc"
}

variable "description" {
  description = "The description fo the VPC."
  type        = string
  default     = "Cloud recipe"
}

variable "routing_mode" {
  default     = "GLOBAL"
  type        = string
  description = "The routing mode for the VPC."
}

variable "auto_create_subnetworks" {
  description = "If true, the module will create a subnet for each region automatically across the 10.128.0.0/9 address range. If false, we need to define the subnets explicitly."
  type        = bool
  default     = false
}
