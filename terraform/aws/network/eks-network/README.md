# VPC for EKS

A recipe for creating a custom VPC for hosting EKS clusters.

This recipe produces the following resources and functions:

* A custom VPC with the following resources:
  * 3 private subnets, 1 per availability zone.
  * 3 public subnets, 1 per availability zone. 
  * 3 NATs, 1 per subnet.
  * 1 internet gateway (IG).
  * 1 route table for all public subnets with the IG as the gateway.
  * 3 route tables, 1 per private subnet, with NAT as the gateway.

**NOTE: This Terraform module creates resources in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

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

* [Terraform: aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
