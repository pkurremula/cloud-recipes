# VPC

A recipe for creating a shared VPC in GCP. "Shared VPC allows an organization to connect resources from multiple projects to a common Virtual Private Cloud (VPC) network, so that they can communicate with each other securely and efficiently using internal IPs from that network." See [GCP shared VPC overview](https://cloud.google.com/vpc/docs/shared-vpc) for details.

This recipe produces the following resources and functions:

* A shared VPC with auto created subnetworks.

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Notes

* **Shared VPC host only works on project that belongs to an Organization**. See [GCP Organization](https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy) for details.

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
* [Shared VPC Overview](https://cloud.google.com/vpc/docs/shared-vpc)
