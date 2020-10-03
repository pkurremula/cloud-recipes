# GCR with Access Control

A simple recipe for creating a Google Container Register (GCR) for storing Docker images.

First read this [document](../README.md) on how you can implicitly create GCR by pushing an image there.

**NOTE: This creates a resource in AWS after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup
   
1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ TF_VAR_project=[GCP-project-id] terraform apply
   ```

Read [here for instructions to push Docker images to GCR](../README.md).

## Notes

### Bucket Name

GCR uses GCS for the actual storage. Creating a GCR will create GCS bucket if it doesn't exist (or does nothing if the bucket already exists). On destroying the GCR, does not actually destroy the bucket. So this recipe explicitly create a GCS bucket and then associate it with the GCR resource.

The bucket associated with the GCR has a name convention in one of the following forms:

* `artifacts.[project].appspot.com`
* `[location].artifacts.[project].appspot.com` - You get this if you specify a location in the `google_container_registry` resource.

### Access Control

Any [IAM member](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html) (service account, authenticated user, etc) can be granted access to GCR according to the member's specified [role](https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles). 

In this recipe, we create a service account for GKE where it will be granted read access to the GCR for pulling images for deploying to the GKE cluster.

## Reference

* [Terraform: google_container_registry](https://www.terraform.io/docs/providers/google/r/container_registry.html)
* [Terraform: google_storage_bucket](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)
* [Terraform: google_storage_bucket_iam](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html)
* [GCR Access Control](https://cloud.google.com/container-registry/docs/access-control)
* [GCS Roles](https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles)
