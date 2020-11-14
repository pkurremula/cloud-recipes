# Connect to GKE

1. Connect to GKE and set up a context.

   ```bash
   $ gcloud auth application-default login
   $ gcloud auth login
   $ gcloud config set project my-gcp-project
   $ gcloud container clusters get-credentials my-gke
   ```
