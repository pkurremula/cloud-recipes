# Connect to GKE

1. If you don't have a GKE cluster, create one. You can use one of the following ways: gcloud or Terraform.

   ```bash
   $ gcloud config set project <project-id>
   $ gcloud config set compute/region us-west1
   $ gcloud container clusters create dev-gke --num-nodes 1 --region=us-west1
   $ gcloud container clusters get-credentials dev-gke --region=us-west1
   ```
   
   Or use the [default-node-pool](../../terraform/gcp/gke/default-node-pool) recipe in this repo to create a GKE cluster.
   
1. The context added by gcloud includes other metadata, which makes it long. Optionally change the context name.

   ```bash
   $ kubectl config get-contexts
   CURRENT NAME  CLUSTER                        AUTHINFO                       NAMESPACE
   *             gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke
   $ kubectl config rename-context gke_<project>_<region>_dev-gke dev-gke
   
   $ # Now we have a context that's much shorter and easier to remember. 
   $ kubectl config get-contexts
   CURRENT NAME  CLUSTER                        AUTHINFO                       NAMESPACE
   *             dev-gke                        gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke
   ```
