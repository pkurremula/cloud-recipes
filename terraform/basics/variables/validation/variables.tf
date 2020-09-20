// CREDIT: https://www.terraform.io/docs/configuration/variables.html
variable "ami" {
  type        = string
  description = "The AWS AMI id."

  validation {
    condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
    error_message = "The ami value must start with `ami-`."
  }
}

variable "availability_zone" {
  description = "AWS availability zone."
  type = string

  // This is only available on Terraform version 0.13.0 and above.
  validation {
    condition = length(regexall("^[a-z]{2}-", var.availability_zone)) > 0
    error_message = "AWS availability zone value must start with 2 alphabetic character and `-`."
  }
}
