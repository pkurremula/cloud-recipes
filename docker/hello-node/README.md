# Best Practices for Node.js Docker

Here are some best practices for creating a production grade Docker container for a Node.js application.

## Base Image

Pick the right Docker base image depending on your needs. Here're the key Docker base images for Node.js.

| Image Name           | Size (MB) | Description  |
|----------------------|----------:|--------------|
| `node`               |       345 | Latest official Node.js. This identical to `node:stretch`. |
| `node:stretch`       |       345 | Latest official Node.js Docker image based on Debian (full or stretch). |
| `node:stretch-slim`  |        63 | Latest official Node.js Docker image based on Debian (slim). |
| `node:alpine`        |        39 | Latest official Node.js Docker image based on Alpine. |
| `node:14.9.0`        |       345 | This  is identical to `node:14.9.0-stretch`, a specific version 14.9.0 on Debian stretch. |
| `node:14.9.0-alpine` |        39 | This is identical to `14.9.0-alpine` or `14.9.0-alpine3.11` (as Sep 5, 2020), a specific version 14.9.0 on Alpine. |

**Notes**

1. The above base Node.js images are maintained by [the Node.js Docker Team](https://hub.docker.com/_/node).
1. In general if the size of the container is important, use an Alpine based base image.

## Be Specific in Base Image

Usually defining `FROM node` without a tag is bad because this will always retrieve the latest version of node. In practice, it is good to be specific on the version of node and may be even with the base OS distro version. For example:

```dockerfile
FROM node:14.9.0-alpine
```

## Reduce Number of Layers

Every statement in a Dockerfile creates a layer in the Docker container. And each layer takes up space. With more layers, the size of the Docker image increases. 

The following example creates 3 layers.

```dockerfile
RUN apt-get update
RUN apt-get install -y gcc
RUN apt-get install -y libgcc
```

Whereas the following the accomplishes the same thing creates 1 layer.

```dockerfile
RUN apt-get update && \
    apt-get install -y gcc libgcc
```

## Clean Up devDependencies and NPM Cache

The `devDependencies` section of a `package.json` allows us to define the npm packages needed for building and testing our applications. However when releasing the application to production, we should remove the `devDependencies`. Not only does it make the Docker image leaner but more secure by excluding redundant dependencies at runtime especially those that have known security vulnerabilities. Also for a more consistent, repeatable install of the npm packages, it is recommended that you use `npm ci` instead of `npm install`. Read [here](https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci) to understand the difference between `npm ci` and `npm install`.
 
In addition, we clear the cache that NPM uses to verify the integrity of the npm packages for any subsequent changes made to the `node_modules` directory. Since Docker image is the final version for deployment to production, we typically include `npm clean cache --force` in every `npm install` statement in Docker. See [here](https://docs.npmjs.com/cli-commands/cache.html) for details on `npm clean cache`.

Include the following statement to install your npm packages in a Docker image for production. 

```dockerfile
RUN npm ci --production && npm cache clean --force
```

## Order to Optimize Layer Caching

Docker builds images by reading the statements from a Dockerfile. A Docker image is comprised of a series of read-only layers corresponding to the statements in a Dockerfile. Only `COPY`, `ADD`, and `RUN` commands create layers.

To make the operation more efficient, Docker caches the resultant layer when executing each statement in the Dockerfile. Docker will determine if anything is changed by comparing the actual content with the cached content and reuse the content from the previous build as much as possible.

* For `COPY` and `ADD` commands, the contents of the files that are copied to the image are examined and a checksum is determined for each file. That checksum is compared to the checksum of the files in the cache.
* For `RUN`, only the statement is compared. The files associated or produced by the `RUN` command isn't used to determine a cache hit.

"Once the cache is invalidated, all subsequent Dockerfile commands generate new images and the cache is not used." In other words, it is best to put `RUN`, `COPY`, or `ADD` commands that are less frequently subjected to change at the beginning of the Dockerfile so that they they will be invalidated less and reused more frequently. So instead of copying the entire directory and then install/build the project, we generally break the build process this way:

1. Copy the `package.json` over so that we have a manifest for installing the required packages.
1. Install the packages.
1. Copy the application source code over.
1. Build the application.

The rationale is that the installation of packages is long and the dependencies don't change as often as the application source code. We want to cache the former as much as possible. For node.js Dockerfile, here's  how the Dockerfile looks like:

```dockerfile
WORKDIR /app
COPY package*.json ./
RUN npm ci --production && npm clean cache --force
COPY src/ ./
```

## Package Version Pinning

When caching a `RUN` statement, . As a result, we want to include a version to the package. This way when we get to retrieve the version we specify in the Dockerfile and not what was cached.

Here're the handy links to common package repositories:

* [Alpine](https://pkgs.alpinelinux.org/packages)
* [Debian](https://packages.debian.org/index)

### Alpine

For Alpine, the syntax for package version pinning is:

* package_name=a.b.c - Package named package_name with the exact version a.b.c
* package_name>a.b.c - Package named package_name with the minimum version a.b.c

```dockerfile
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    git \
    gcc=10.2.0-r5
```

According to Alpine, they can drop any package version from any branch in the official Alpine package - see [this thread](https://gitlab.alpinelinux.org/alpine/abuild/-/issues/9996). There's a real risk of pinning to an exact version of a package as that exact package may not be available in the future, which can potentially cause issue for your Dockerfile. It might be a good idea to set a minimum package version.

### Debian

For Debian, the syntax for package version pinning is:

* package_name=a.b.c - Package named package_name with the exact version a.b.c

```dockerfile
RUN apt-get update && \
    apt-get install -y \
    git \
    gcc-10=10.2.0-6
```

## Use Multistage

Say we have the following Dockefile that builds and runs the Node.js application.

```dockerfile
FROM node:alpine
WORKDIR /app
COPY --chown=node:node package.json index.js ./
RUN npm install
USER node
EXPOSE 8080
CMD ["node", "/app/index.js"]
```

We can use multistage Docker to build a smaller Docker image. All the layers in the build stage will be copied over to the last stage as 1 layer.

```dockerfile
FROM node:alpine as build
WORKDIR /app
COPY package.json index.js ./
RUN npm install

FROM node:alpine
COPY --from=build --chown=node:node /app /app
USER node
EXPOSE 8080
CMD ["node", "/app/index.js"]
```

## References

* [Best Practice](https://medium.com/@nodepractices/docker-best-practices-with-node-js-e044b78d8f67)
