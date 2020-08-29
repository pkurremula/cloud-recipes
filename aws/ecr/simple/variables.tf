variable "region" {
  description = "The AWS region."
  type        = string
}

variable "repo_name" {
  description = "Name of the repository."
  type        = string
}

variable "scan_on_push" {
  description = "Whether Docker images are scanned after they are pushed ot the repository."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags associated with this repository."
  type        = map(string)
  default     = {}
}
