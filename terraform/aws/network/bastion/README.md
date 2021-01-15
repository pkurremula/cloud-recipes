# Bastion

In [private and public subnets recipe](../public-private-subnets), we create a VPC with private and public subnets. We set up instances in the private subnet for running secure workloads. There's just one problem: we need a way to access the hosts in the private network.

This recipe extends the private and public subnets recipe by setting up a bastion host in the public subnet to provide a way to connect to the hosts in the private subnet. It also set up the Internet gateway and route table.

This recipe produces the following resources and functions:

* A custom VPC with the following resources and configuration:
  * A private subnet.
  * A public subnet.
  * An Internet gateway.
  * NAT and proper routing to the subnets.
* An EC2 instance as bastion host.
* Proper security grouops.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

1. Run `create-sshkey.sh` to create an SSH key pair. The key files created will be ignored by git - see [.gitignore](.gitignore). 

   ```bash
   $ ./create-sshkey.sh
   ```
   
1. Run Terraform. Note the value `test_private_ip` from the output.

   ```bash
   $ terraform init
   $ terraform apply
   ```

1. Connect to the bastion.

   ```bash
   $ ssh -i id-rsa-bastion -A ec2-user@$(tf output bastion_dns_name)
   ```

1. On the bastion, run this command.

   ```bash
   $ ssh ec2-user@[test_private_ip]
   ```

## Reference

* [Terraform: aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
* [Terraform: aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
* [Terraform: aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
* [Terraform: aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)
* [Terraform: aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)
* [Terraform: aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)
* [Terraform: aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)
* [Terraform: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [Linux Bastion Hosts on AWS](https://aws.amazon.com/quickstart/architecture/linux-bastion/)
* [Mitigating SSH-Based Attacks - Top 15 Best Security Practices](https://securitytrails.com/blog/mitigating-ssh-based-attacks-top-15-best-security-practices)
