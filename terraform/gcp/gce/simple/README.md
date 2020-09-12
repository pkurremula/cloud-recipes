# Simple GCE Creation

This recipe uses the bare minimum to create an GCE instance on GCP. It uses the `google_compute_instance` resource module with 5 required parameters:

* `boot_disk` - The boot disk including the OS image to use.
* `machine_type` - The machine type to create.
* `name` - Name for the instance.
* `zone` - The zone where the instance will be located.
* `network_interface` - The network attached to the instance.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Reference

* [Terraform: google_compute_image](https://www.terraform.io/docs/providers/google/r/compute_image.html)
* [Terrafrom: google_compute_instance](https://www.terraform.io/docs/providers/google/r/compute_instance.html)
* [GCP Instance Types](https://cloud.google.com/compute/docs/machine-types)
* [GCP Pricing Calculator](https://cloud.google.com/products/calculator)
* [GCE Images](https://cloud.google.com/compute/docs/images)
* [GCE Image Operating System Details](https://cloud.google.com/compute/docs/images/os-details)
