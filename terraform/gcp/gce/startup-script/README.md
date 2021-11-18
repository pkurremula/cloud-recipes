# Startup Script for GCE Host

When we launch an GCE instance on GCP, we get to pass a shell script to start a service or configure the GCE host. This recipe leverages the Terraform `templatefile` function to inject values to the startup script before it is passed to the GCE host during its creation.

This recipe produces the following resources and functions:

* A GCE instance running Centos.
* Boot the GCE instance with a startup script injected with variables from Terraform.
* Firewall rules with ports 80 and 443 ingress and anywhere egress.
* Random select an availability zone within the region.

**NOTE: This Terraform module creates resources on GCP, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Setup

1. Create the `terraform.tfvars` file and enter the pertinent values like project id. Note this file is not checked into the repo, so you can enter your project id and project number in the file.

   ```bash
   $ vi terraform.tfvars
   ```

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

1. Wait about a minute for the startup script to fully configure the new system before testing the web server by running.

   ```bash
   $ curl "http://$(terraform output public_ip):8080"
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

### Startup Script Execution Log

It's good to examine the execution log of user-data to help troubleshot should things go wrong. We can SSH into the host and read the log file. See the [startup script](startup.sh).

```bash
$ cat /var/log/startup.log
``` 

## Credits

* [Hellonode](https://github.com/GoogleCloudPlatform/container-engine-samples/blob/master/hellonode/server.js)

## Reference

* [Terraform: google_compute_image](https://www.terraform.io/docs/providers/google/r/compute_image.html)
* [Terraform: google_compute_instance](https://www.terraform.io/docs/providers/google/r/compute_instance.html)
* [Terraform: templatefile](https://www.terraform.io/docs/configuration/functions/templatefile.html)
* [GCP Instance Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GCE Images](https://cloud.google.com/compute/docs/images)
* [GCE Image Operating System Details](https://cloud.google.com/compute/docs/images/os-details)
* [NVM: Node Version Manager](https://github.com/nvm-sh/nvm)
* [PM2](https://github.com/Unitech/pm2)
