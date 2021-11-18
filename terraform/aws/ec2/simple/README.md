# Simple EC2 Creation

This recipe uses the bare minimum to create an EC2 instance on AWS. It uses the `aws_instance` resource module with 2 required parameters:

* `ami` - The AMI to use for the instance.
* `instance_type` - The type of instance to create.

This recipe produces the following resources and functions:

* A GCE instance with default values.

**NOTE: This Terraform module creates resources on AWS, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Reference

* [Terraform: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
