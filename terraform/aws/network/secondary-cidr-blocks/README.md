# Secondary CIDR Blocks

A recipe for creating a VPC with specified secondary CIDR blocks, which are useful for extending the number of IP addresses in a VPC.

This recipe produces the following resources and functions:

* A custom VPC with secondary cidr blocks.

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

* [Terraform: aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
* [Terraform: aws_vpc_ipv4_cidr_block_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association)
* [AWS: VPCs and Subnet Sizing](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html#VPC_Sizing)
* [IP Address Guide](https://www.ipaddressguide.com/cidr) - CIDR calculator
