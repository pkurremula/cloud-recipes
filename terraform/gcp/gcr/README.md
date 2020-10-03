# GCR

Each GCP Project has a default private Google Container Registry (GCR) in a GCP project

## Setup

Use the following steps to push a Docker image to the private GCR.

1. Go to the directory containing the Dockerfile.

   ```bash
   $ cd ../../../docker/hello-go
   $ docker build -t hello-go:latest .  # Build and tag
   $ docker run --rm -p 8080:8080 hello-go:latest
   ```

1. Configure docker.

   ```bash
   $ # Do this one time
   $ gcloud auth configure-docker
   ```

1. Tag the Docker image with 

   ```bash
   $ export GCP_PROJECT="$(gcloud config get-value project -q)"
   $ docker tag hello-go:latest "gcr.io/${GCP_PROJECT}/hello-go"
   $ docker images | grep hello-go
   hello-go                         latest   207de9d56ba7  About a minute ago   13.5MB
   gcr.io/my-gcp-project/hello-go   latest   207de9d56ba7  About a minute ago   13.5MB
   $ docker push "gcr.io/${GCP_PROJECT}/hello-go"
   ```

1. Go to the [GCR](https://console.cloud.google.com/gcr/images) in your GCP Project to check the Docker image that you just pushed.

  Go to the [GCS](https://console.cloud.google.com/storage/browser) in your GCP Project. You will also notice that GCP implicitly created a bucket to actually store the Docker image you just pushed.

1. You can now pull from GCR. But first remove the cached image.

   ```bash
   $ docker rmi "gcr.io/${GCP_PROJECT}/hello-go"
   $ docker images | grep hello-go
   hello-go                         latest   207de9d56ba7  About a minute ago   13.5MB
   ```

   Now pull the image form GCR.

   ```bash
   $ docker pull "gcr.io/${GCP_PROJECT}/hello-go"
   $ docker images | grep hello-go
   hello-go                         latest   207de9d56ba7  About a minute ago   13.5MB
   gcr.io/my-gcp-project/hello-go   latest   207de9d56ba7  About a minute ago   13.5MB
   ```

## Terraform GCR

We just showed how you can push a Docker image to a private GCR in your GCP project. If the container registry and bucket doesn't exist, GCP will create them for you. However you can also explicitly create a GCR using Terraform. One advantage of doing it this way is that you can bind IAM roles to the GCR programmatically via Terraform. Go to [GCR Terraform recipe](access-control).
