# Simple EC2 Cluster Creation

This recipe creates a cluster of multiple EC2 instances as specified by the variable `instance_count`.

This recipe produces the following resources and functions:

* Multiple EC2 instances.

**NOTE: This Terraform module creates resources on AWS, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

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

* The use of function `element` in the recipe provides a wrap-around behavior. For example, say `instance_count` is assigned with 4. But our `subnet_ids` is only 3 element long. When we pass a `4` to the `element` function, the function will just wrap around and return the first element.

## Reference

* [Terraform: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
