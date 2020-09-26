# Bastion

In [private and public subnets recipe](../public-private-subnets), we create a VPC with private and public subnets. We set up instances in the private subnet for running secure workloads. There's just one problem: we need a way to access the hosts in the private network.

This recipe extends the private and public subnets recipe by setting up a bastion host in the public subnet to provide a way to connect to the hosts in the private subnet. It also set up the Internet gateway and route table.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

1. Run `create-sshkey.sh` to create an SSH key pair. The key files created will be ignored by git - see [.gitignore](.gitignore). 

   ```bash
   $ ./create-sshkey.sh
   ```
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
* [Terraform: aws_default_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group)
* [Linux Bastion Hosts on AWS](https://aws.amazon.com/quickstart/architecture/linux-bastion/)
