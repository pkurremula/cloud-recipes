# VPC for GKE

A recipe for creating a VPC for hosting GKE clusters. It creates 2 private subnets: 1 primary subnet and 1 subnet with secondary IP range, specifically for GKE.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
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

* [Terraform: google_compute_network](https://www.terraform.io/docs/providers/google/r/compute_network.html)
* [Terraform: google_compute_subnetwork](https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html)
* [Terraform: google_compute_router_nat](https://www.terraform.io/docs/providers/google/r/compute_router_nat.html)
* [Terraform: google_compute_router](https://www.terraform.io/docs/providers/google/r/compute_router.html)
