# Template File

Here's an example of using the `templatefile` function.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
1. Run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Notes

### String Interpolation

The `templatefile` function uses the standard Terraform string interpolation. This means that the `${...}` sequence is used to substitute a string value directly into the template. And the `%{...}` or `%{... ~}` to enable conditional and iteration expression.

The `${...}` sequence in Terraform string template sometimes conflicts with the `${...}` variable syntax in the shell script, eg. say we have a template file that is a bash script that contains `${my_shell_variable}`, is that a Terraform template string variable or a shell variable. In this context, use a dollar sign character to escape the `${...}` sequence - this feature isn't well documented in Terraform. In other words, for the Terraform string variable use `${my_tf_variable}` and for the shell variable use `$${my_shell_variable}`.

## Reference

* [Terraform: templatefile](https://www.terraform.io/docs/configuration/functions/templatefile.html)
* [Terraform: String templates](https://www.terraform.io/docs/configuration/expressions.html#string-templates)
