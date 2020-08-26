# Security Group Rules Using Dynamic Block

This recipe creates multiple rules of a security group using the `dynamic` block and a list.

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

## Reference

* [Terraform: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
