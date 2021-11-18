# GCR with Access Control

A simple recipe for granting a service read access to a Google Container Register (GCR).

We really don't need Terraform to create GCR as GCR is implicitly created by pushing an image to the repository. Read this [document](../README.md) for details. However, we do need to tweak the access control and a common use case is when you need to pull an image from GCR for deployment.

This recipe produces the following resources and functions:

* Grant a service account in GKE read access to GCR for pulling images for deployment in a GKE cluster.

**NOTE: This Terraform module creates resources on AWS, which you will be charged. Don't forget to remove the resources by running `terraform destroy` after you are done.**

## Setup
   
1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
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
