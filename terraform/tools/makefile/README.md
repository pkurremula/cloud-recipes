# Sample Makefile

Sometimes it's good to use `make` to automate a Terraform run. Here's a sample Makefile for a terraform project.

## Setup
   
1. Get a list of the Makefile targets.

   ```bash
   $ make help
    Usage:
     make <target>
   
     apply     Apply terraform
     prep      Prepare for Terraform run
     init      Initialize terraform
     destroy   Destroy terraform
     plan      Plan terraform
     clean     Clean output files and build cache
     help      Help
   ```   
   
1. Run terraform to create resources.

   ```bash
   $ make
   ```
