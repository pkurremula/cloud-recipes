# VPC for GKE

A recipe for creating a custom VPC for hosting GKE clusters. It creates 2 private subnets: 1 primary subnet and 1 subnet with secondary IP ranges, specifically for GKE.

This recipe produces the following resources and functions:

* A custom VPC with the following resources:
  * A subnet for non-GKE usage.
  * A subnet for GKE clusters with pods and services secondary ip ranges.
  * A nat routing setup for both subnets.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
1. Create a `terraform.tfvars` and enter the pertinent values, including the project id.

   ```bash
   $ vi terraform.tfvars
   ```   
   
1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: google_compute_network](https://www.terraform.io/docs/providers/google/r/compute_network.html)
* [Terraform: google_compute_subnetwork](https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html)
* [Terraform: google_compute_router_nat](https://www.terraform.io/docs/providers/google/r/compute_router_nat.html)
* [Terraform: google_compute_router](https://www.terraform.io/docs/providers/google/r/compute_router.html)
