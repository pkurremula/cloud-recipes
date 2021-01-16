# Environment Variables Injection

This is a recipe that shows how environment variables are injected to the container.

**Change the image prefix to a different location where you have write access (ie. something different from cybersamx)**.

## Setup

### Local Build and Run

1. Build Docker container.

   ```bash
   $ docker-compose build
   ```
   
1. Run Docker container.

   ```bash
   $ docker-compose up
   ```

### Push to Registry

1. To push to Docker Hub.

   ```bash
   $ docker push cybersamx/env-go
   ```
   
1. To push to GCR, see [here](../../../docker/gcr.md).

## Reference

* [The Official Go Docker Image](https://hub.docker.com/_/golang)
