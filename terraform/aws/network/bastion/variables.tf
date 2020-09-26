variable "region" {
  description = "The AWS region."
  type        = string
}

variable "name" {
  description = "Name of the VPC."
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

variable "bastion_ami_id" {
  description = "The AMI ID to use for the bastion host."
  type        = string
  default     = ""
}

variable "bastion_instance_type" {
  description = "The instance type for the bastion host."
  type        = string
  default     = "t3.nano"
}
