# Push to GCR

How to push a Docker image to GCR?

1. Configure Docker.

   ```bash
   $ gcloud auth configure-docker
   ```

1. Build and tag the container image. Tag the local Docker image using this format: `docker tag [SOURCE_IMAGE] [HOSTNAME]/[PROJECT-ID]/[IMAGE]`. Where `HOSTNAME` is `gcr.io` and let's suppose the `SOURCE_NAME` is named `hello-go`.

   ```bash
   $ # Build and tag the docker image locally.
   $ docker build -f Dockerfile -t gcr.io/my-project/hello-go:new-feature .
   $ # You should now see the image locally
   $ docker images
   REPOSITORY                   TAG         IMAGE ID       CREATED
   gcr.io/my-project/hello-go   new-feature 9b667dbe0fc9   9 minutes ago
   ```

1. Push the image to GCR.

   ```bash
   $ docker push gcr.io/my-project/hello-go:new-feature
   ```
