# ICMP Security Group

Sometimes you need to have this security group to allow incoming ICMP (ping) for testing. This example shows the settings.

This recipe produces the following resources and functions:

* A ICMP security group.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [ICMP Parameters](https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml)
