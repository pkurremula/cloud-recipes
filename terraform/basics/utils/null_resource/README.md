# Trigger

Terraform resource module `null_resource` can be configured to detect changes and raise a trigger. In this recipe we set up the `trigger` parameter on run a set of local shell commands whenever the content of the config file changes.

## Use Case

There are 2 use cases that invoke the provisioner:

1. Whenever the content of a file is changed.
1. Whenever the module is created and destroyed.

## Setup

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply -auto-approve
   ```

   Running it the first time, we see that the `local-exec` provisioner is triggered and invoked. So we have a resource (and state) added. For the `one_time` module, it creates a lock file.

1. Run `terraform apply -auto-approve` again. Nothing happens as it should because the config file isn't changed.

1. Change the content of `config.json` and run `terraform apply -auto-approve` again. You will see that `null_resource` is now triggered.

1. Run `terraform destory -auto-approve`. The provisioner with the destroy clause in the `one_time` module is not invoked and remove the file that was created when the module was first created. 

## Reference

* [Terraform: null_resource](https://www.terraform.io/docs/provisioners/null_resource.html)
