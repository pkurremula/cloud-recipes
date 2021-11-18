variable "region" {
  description = "The AWS region."
  type        = string
}

variable "profile" {
  description = "The AWS profile to run Terraform."
  type        = string
  default     = "default"
}

variable "prefix" {
  description = "The prefix for naming the resources."
  type        = string
  default     = "dev"
}

variable "vpc" {
  description = "The VPC settings."
  type        = map(string)
  default = {
    cidr = "10.0.0.0/16"
  }
}

variable "subnets" {
  description = "The private subnet settings."
  type        = map(list(string))
  default = {
    public_cidrs  = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
    private_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
}
