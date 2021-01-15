variable "region" {
  description = "The AWS region."
  type        = string
  default     = "us-west-2"
}

variable "vm" {
  description = "Configurations for the VM instances."
  type        = map
  default = {
    instance_prefix = "host"
    instance_type   = "t3.nano"
    instance_count  = 1
    subnet_ids      = []
    // If ami_id == "" then we determine and use the latest Amazon Linux image.
    // Assign an image id to override the default image.
    ami_id = ""
    tags = {
      repo = "https://github.com/cybersamx/cloud-recipes"
    }
  }
}
