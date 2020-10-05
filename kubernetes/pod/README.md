# Pod

Create a pod.

One of the simplest manifest file for creating a pod is [pod.yaml](pod-simple.yaml). Other variants of creating the same pod but with additional configurations or add-ons can be found in [variants](variants).

## Setup

1. Create a GKE cluster with one of the following ways: gcloud or Terraform.

   ```bash
   $ gcloud config set compute/zone us-west1
   $ gcloud container clusters create dev-gke
   ```
   
   Or use the [default-node-pool](../../terraform/gcp/gke/default-node-pool) recipe in this repo to create a GKE cluster.
   
1. The context added by gcloud includes other metadata, which makes it long. Optionally change the context name.

   ```bash
   $ kubectl config get-contexts
   CURRENT NAME                           CLUSTER                        AUTHINFO                       NAMESPACE
   *       gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke
   $ kubectl config rename-context gke_<project>_<region>_dev-gke dev-gke
   $ kubectl config get-contexts
   CURRENT NAME                           CLUSTER                        AUTHINFO                       NAMESPACE
   *       dev-gke                        gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke
   ```

1. Create the pod.

   ```bash
   $ kubectl apply -f pod.yaml
   $ kubectl get pods                        
   NAME       READY   STATUS    RESTARTS   AGE
   hello-go   1/1     Running   0          11s
   $ kubectl port-forward hello-go 8080:8080
   Forwarding from 127.0.0.1:8080 -> 8080
   Forwarding from [::1]:8080 -> 8080
   ```

   On a separate shell, run the following:
   
   ```bash
   $ curl localhost:8080
   Hello, World!
   Server: hello-go
   ```

