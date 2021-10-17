# GCB Trigger Inline

There are 2 recipes here:

* Inline build configuration - we are defining the build configuration directly in Terraform and embedding it to the GCB trigger.
* Parallel build steps - show how we define the build steps that execute in parallel. Use the attribute `wait_for` to enable parallelism. Read [here](https://cloud.google.com/cloud-build/docs/configuring-builds/configure-build-step-order) for details.

See [the full GCB recipe](../full) first.

## Image

Here are some cloud builders we can use in a GCB build step.

* [List of official cloud builders](https://github.com/GoogleCloudPlatform/cloud-builders) - You reference these cloud builders this way `gcr.io/cloud-builders`.
* [List of community-supported cloud builders](https://github.com/GoogleCloudPlatform/cloud-builders-community) - You have to manually push them to the GCR in your GCP project.

Also, GCB accepts any image from Docker Hub, just pass it a name eg. `alpine` or `ubuntu`.
