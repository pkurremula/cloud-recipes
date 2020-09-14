# Simple GCE Creation

This recipe uses the bare minimum to create an GCE instance on GCP. It uses the `google_compute_instance` resource module with 5 required parameters:

* `boot_disk` - The boot disk including the OS image to use.
* `machine_type` - The machine type to create.
* `name` - Name for the instance.
* `zone` - The zone where the instance will be located.
* `network_interface` - The network attached to the instance.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

1. If we are running this the first time, we need to enable Google Compute Engine (GCE) API so that we can interface with GCE programmatically. Just need to run this once.

   ```bash
   $ gcloud services enable compute.googleapis.com
   ```

1. Create a `terraform.tfvars` and enter the pertinent values.

   ```bash
   $ vi terraform.tfvars
   ```

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ TF_VAR_project=[GCP-project-id] terraform apply
   ```

## Reference

* [Terraform: google_compute_image](https://www.terraform.io/docs/providers/google/r/compute_image.html)
* [Terrafrom: google_compute_instance](https://www.terraform.io/docs/providers/google/r/compute_instance.html)
* [GCP Instance Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GCE Images](https://cloud.google.com/compute/docs/images)
* [GCE Image Operating System Details](https://cloud.google.com/compute/docs/images/os-details)
