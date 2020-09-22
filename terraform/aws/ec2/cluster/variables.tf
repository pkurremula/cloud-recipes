variable "region" {
  description = "The AWS region."
  type        = string
}

variable "instance_prefix" {
  description = "The name prefix of the EC2 instance."
  type        = string
  default     = "host"
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

variable "instance_count" {
  description = "Number of instances."
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "A list of subnet IDs in where the instance will launch."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags associated with the EC2 instance."
  type        = map(string)
  default     = {}
}
