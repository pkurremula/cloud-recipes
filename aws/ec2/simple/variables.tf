variable "region" {
  description = "The AWS region."
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
