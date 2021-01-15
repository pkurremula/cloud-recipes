variable "region" {
  description = "The AWS region."
  type        = string
  default     = "us-west-2"
}

variable "security_group" {
  description = "Configurations for the security groups."
  type = map
  default = {
    vpc_id = ""
  }
}

variable "vm" {
  description = "Configuration for the VM instance."
  type = map
  default = {
    // If ami_id == "" then we determine and use the latest Amazon Linux image.
    // Assign an image id to override the default image.
    ami_id        = ""
    instance_type = "t3.nano"
    instance_name = "production-ec2"
    tags = {
      repo = "https://github.com/cybersamx/cloud-recipes"
    }
  }
}
