variable "region" {
  description = "The AWS region."
  type        = string
  default     = "us-west-2"
}

variable "vm" {
  description = "Configurations for the VM instance."
  type        = map
  default = {
    ami_id        = ""
    instance_type = "t3.nano"
  }
}
