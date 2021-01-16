# Push to GCR

How to push a Docker image to GCR?

1. Configure Docker.

   ```bash
   $ gcloud auth configure-docker
   ```

1. Tag the local Docker image using this format: `docker tag [SOURCE_IMAGE] [HOSTNAME]/[PROJECT-ID]/[IMAGE]`. Where `HOSTNAME` is `gcr.io` and let's suppose the `SOURCE_NAME` is named `hello-go`.

   ```
   $ docker tag hello-go gcr.io/my-project/hello-go
   ```
