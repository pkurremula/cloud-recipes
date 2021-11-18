# User-data for EC2 Host

When we launch an EC2 instance on AWS, we get to pass a shell script to start a service or configure the EC2 host. This recipe leverages the Terraform `templatefile` function to inject values to the startup script before it is passed to the EC2 host during its creation.

This recipe produces the following resources and functions:

* A EC2 instance running Amazon Linux.
* Boot the GCE instance with a user-data (startup) script injected with variables from Terraform.
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

1. Test the web server by running.

   ```bash
   $ curl "http://$(terraform output public_dns):8080"
   ```

1. Connect to the instance.

   ```bash
   $ ssh -i ./id-terraform-rsa "ec2-user@$(terraform output public_dns)"
   ```

## Notes

### templatefile Function

For Terraform 0.12 and above, use function `templatefile` instead of the module `data.template_file`. The following are equivalent:

```hcl-terraform
data "template_file" "startup_script" {
  template = file("${path.module}/${local.startup_script_file}")

  vars = {
    port         = 8080
    node_version = "v12.13.0"
  }
}
```

```hcl-terraform
templatefile("${path.module}/${local.startup_script_file}", {
  port         = 8080
  node_version = "v12.13.0"
})
```

### Installing Node.js on Amazon Linux

We are using Amazon Linux 2 for the EC2 host to be created with this recipe. To install `node.js` with the package manager `yum` that comes with operating system, we run the following:

```bash
amazon-linux-extras install -y epel
yum install -y nodejs
```

Unfortunately the package manager installs a pretty dated version of node. So we are using `nvm` to install a new version of node. It's recommended that we use `nvm` as it allows us to select and install a version of node - even the [official AWS documentation recommends using nvm](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html). The user-data uses nvm to install.

### User-data Execution Log

It's good to examine the execution log of user-data to help troubleshot should things go wrong. We can SSH into the host and read the log file. See the [user-data script](user-data.sh).

```bash
$ cat /var/log/user-data.log
``` 

## Credits

* [Hellonode](https://github.com/GoogleCloudPlatform/container-engine-samples/blob/master/hellonode/server.js)

## Reference

* [Terraform: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
* [Terraform: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [Terraform: templatefile](https://www.terraform.io/docs/configuration/functions/templatefile.html)
* [NVM: Node Version Manager](https://github.com/nvm-sh/nvm)
* [PM2](https://github.com/Unitech/pm2)
* [AWS Instance Types](https://aws.amazon.com/ec2/instance-types)
