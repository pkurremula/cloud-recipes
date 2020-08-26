# Security Group

Here's a recipe that creates security groups in AWS. 

There are 2 ways to define an AWS security group:

1. Using a standalone `aws_security_group` module with embedded `ingress` and `egress` blocks.
1. Using a `aws_security_group` module with associated a set of `aws_security_group_rule` modules

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
1. Create a `terraform.tfvars` and enter the pertinent values.

   ```bash
   $ vi terraform.tfvars
   ```   
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Notes

1. Setting `protocol = -1` or `protocol = "all"` will create a security group rule that allows all network protocols.
1. Setting `from_port = 0` and `to_port = 0` will create a security group rule that opens all ports.

## Reference

* [Terraform: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
