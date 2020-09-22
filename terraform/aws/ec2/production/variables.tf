variable "region" {
  description = "The AWS region."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default     = "t3.nano"
}

variable "instance_name" {
  description = "The name of the EC2 instance."
  type        = string
  default     = "tf-production-ec2"
}

variable "tags" {
  description = "Tags associated with the EC2 instance."
  type        = map(string)
  default     = {}
}

