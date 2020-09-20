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

variable "public_subnets" {
  description = "List of public subnet configurations."
  type = list(object({
    name          = string
    az            = string
    cidr          = string
    map_public_ip = bool // Map an auto-assigned public IP address.
  }))
  default = []
}

variable "private_subnets" {
  description = "List of private subnet configurations."
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
  default = []
}
