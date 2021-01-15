variable "region" {
  description = "The AWS region."
  type        = string
}

variable "security_group" {
  description = "Configuration for the security groups."
  type        = map
  default = {
    vpc_id = ""
  }
}

variable "vm" {
  description = "Configurations for the VM instance."
  type        = map
  default = {
    // If ami_id == "" then we determine and use the latest Amazon Linux image.
    // Assign an image id to override the default image.
    ami_id        = ""
    instance_type = "t3.nano"
    instance_name = "production-ec2"
    port          = 8080
    node_version  = "v12.13.0"
    tags = {
      repo = "https://github.com/cybersamx/cloud-recipes"
    }
  }
}
