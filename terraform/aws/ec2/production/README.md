# EC2 Creation for Production

The previous recipe [simple EC2](../simple) is a good recipe to get one familiarized with running Terraform on AWS and started with creating an EC2 instance using 2 parameters in the `aws_instance` resource module.

However, you want to be able to pass additional parameters to configure the EC2 instance for production use. In this recipe we will refine what we have built in the simple EC2 recipe with additional configurations.

This recipe produces the following resources and functions:

* An EC2 instance with more customizable configurations/options so that we can provision the resource better for production use.
* A ssh key assigned to the instance.
* Security groups associated with the instance.

**NOTE: This Terraform module creates resources on AWS, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Setup

1. Run `create-sshkey.sh` to create an SSH key pair. The key files created will be ignored by git - see [.gitignore](.gitignore). 

   ```bash
   $ ./create-sshkey.sh
   ```
   
1. Create a `terraform.tfvars` and enter the pertinent values.

   ```bash
   $ vi terraform.tfvars
   ```   
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

1. Connect to the instance.

   ```bash
   $ ssh -i ./id-terraform-rsa "ec2-user@$(terraform output public_dns)"
   ```

## Notes

### Parameters security_groups vs vpc_security_group_ids

If you are creating EC2 instances in the default VPC, pass a list of security group IDs to `security_groups`. Otherwise if you created a VPC, pass the security group IDs to `vpc_security_group_ids` instead.

## Reference

* [Terraform: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
