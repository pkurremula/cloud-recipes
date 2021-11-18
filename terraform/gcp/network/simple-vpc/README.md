# VPC

A simple recipe for creating a VPC in GCP.

This recipe produces the following resources and functions:

* A simple custom VPC with default values.

**NOTE: This Terraform module creates resources on GCP, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Setup
   
1. Create a `terraform.tfvars` and enter the pertinent values, including the project id.

   ```bash
   $ vi terraform.tfvars
   ```   
   
1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: google_compute_network](https://www.terraform.io/docs/providers/google/r/compute_network.html)
