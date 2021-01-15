# Full Google Cloud Build

This recipe creates a full Cloud Build (GCB) with the following:

* Service accounts associated with GCB with permissions to run GCB pipelines, access to GCS and GCR, and deployment to GKE/GCE.
* GCB Trigger

**NOTE: This creates a resource in GCP after running `terraform apply`. Don't forget to remove the resource by running `terraform destroy` after you are done.**

## Setup

### Interactive Console Setup

There's some interactive setup on the GCP console involved before we can run the Terraform module.

1. Go to the [Github Marketplace](https://github.com/marketplace). Search for **Google Cloud Build**.
1. Click on **Google Cloud Build** and get redirected to the [app page](https://github.com/apps/google-cloud-build). Click the **Setup with Google Cloud Build** button.
1. Select **only select repositories** and select at least 1 repositories.
1. Click **Install** button. 
1. Get redirected to GCP console.
1. Select the project, repository, and trigger.
1. We can delete the trigger that is created from the wizard.

### Terraform Setup

1. Create the `terraform.tfvars` file and enter the pertinent values like project id. Note this file is not checked into the repo, so you can enter your project id and project number in the file.

   ```bash
   $ vi terraform.tfvars
   ```

1. Initialize and run Terraform.

   ```bash
   $ terraform init
   $ terraform apply
   ```

## Reference

* [Terraform: google_cloudbuild_trigger](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger)
* [Google Cloud: Configuring access for Cloud Build Service Account](https://cloud.google.com/cloud-build/docs/securing-builds/configure-access-for-cloud-build-service-account)
