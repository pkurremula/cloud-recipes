variable "region" {
  description = "The AWS region."
  type        = string
}

variable "name" {
  description = "Name of the VPC."
  type        = string
}

variable "cidr" {
  description = "The CIDR for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags associated with this repository."
  type        = map(string)
  default     = {}
}
