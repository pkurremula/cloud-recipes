# Go Docker Container

An image can be used to create a shell session within a Kubernetes cluster for testing and troubleshooting. It is still a work-in-progress, hope to add more tools.

## Setup

1. Build Docker container.

   ```bash
   $ docker-compose build
   ```
   
1. Run Docker container.

   ```bash
   $ docker-compose up
   ```

### Push to the Repository

1. Change the image name in `docker-compose.yaml`, ie. use a different image name other than `cybersamx/hello-go`.

   ```bash
   $ vi docker-compose.yaml
   ```

1. Log into the registry that you assigned the image to. This usually means.

   ```bash
   $ docker login
   ```
   
1. Push the image.

   ```bash
   $ docker-compose push
   ```

## Reference

* [The Official Go Docker Image](https://hub.docker.com/_/golang)
