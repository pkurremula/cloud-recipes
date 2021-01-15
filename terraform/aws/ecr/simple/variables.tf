variable "region" {
  description = "The AWS region."
  type        = string
}

variable "ecr" {
  description = "Configurations for the ECR."
  type = map
  default = {
    repo_name    = ""
    scan_on_push = true
    tags = {
      repo = "https://github.com/cybersamx/cloud-recipes"
    }
  }
}
