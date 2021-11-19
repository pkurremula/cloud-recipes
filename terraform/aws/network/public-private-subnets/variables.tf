variable "region" {
  description = "The AWS region."
  type        = string
}

variable "name" {
  description = "Name of the VPC."
  type        = string
}

variable "profile" {
  description = "The AWS profile"
  type        = string
}

variable "env" {
  description = "The environment associated with the VPC."
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags associated with the VPC."
  type        = map(string)
  default     = {}
}

variable "public_subnets" {
  description = "List of public subnet configurations."
  type = list(object(
    {
      name          = string
      az            = string
      cidr          = string
      map_public_ip = bool // Map an auto-assigned public IP address.
    }
  ))
}

variable "private_subnets" {
  description = "List of private subnet configurations."
  type = list(object(
    {
      name = string
      az   = string
      cidr = string
    }
  ))
}
