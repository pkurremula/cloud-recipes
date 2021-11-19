variable "region" {
  description = "The AWS region."
  type        = string
}

variable "profile" {
  description = "The AWS profile to run Terraform."
  type        = string
  default     = "default"
}

variable "prefix" {
  description = "The prefix for naming the resources."
  type        = string
  default     = "dev"
}

variable "eks" {
  description = "EKS settings."
  type        = map(string)
  default = {
    kubernetes_version = "1.21"
  }
}

variable "workers" {
  description = "EKS workers settings."
  type        = any
  default = {
    desired_size  = 1
    min_size      = 1
    max_size      = 2
    instance_type = "t3a.nano"
  }
}

variable "subnets" {
  description = "The subnet settings."
  type        = map(list(string))
  default = {
    public_cidrs  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    private_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
}
