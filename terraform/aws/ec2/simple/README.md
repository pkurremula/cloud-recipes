# Simple EC2 Creation

This recipe uses the bare minimum to create an EC2 instance on AWS. It uses the `aws_instance` resource module with 2 required parameters:

* `ami` - The AMI to use for the instance.
* `instance_type` - The type of instance to create.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Reference

* [Terraform: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
