# Trigger

Terraform resource module `null_resource` can be configured to detect changes and raise a trigger. In this recipe we set up the `trigger` parameter on run a set of local shell commands whenever the content of the config file changes.

## Setup

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply -auto-approve
   ```

   Running it the first time, we see that the `local-exec` provisioner is triggered. So we have a resource added. And that state is added.

1. Run `terraform apply -auto-approve` again. Nothing happens as it should because the config file isn't changed.

1. Change the content of `config.json` and run `terraform apply -auto-approve` again. You will see that `null_resource` is now triggered.
## Reference

* [Terraform: null_resource](https://www.terraform.io/docs/provisioners/null_resource.html)
