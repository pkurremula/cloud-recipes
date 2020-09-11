# Node.js Docker Container

## Setup

1. Build Docker container.

   ```bash
   $ docker-compose build
   ```
   
1. Run Docker container.

   ```bash
   $ docker-compose up
   ```

## Best Practices

Here are some best practices for building Node.js containers for production.

### Base Image

Pick the right Docker base image depending on your needs. Here're the key Docker base images for Node.js.

| Image Name           | Size (MB) | Description  |
|----------------------|----------:|--------------|
| `node`               |       345 | Latest official Node.js. This identical to `node:stretch`. |
| `node:stretch`       |       345 | Latest official Node.js Docker image based on Debian (full or stretch). |
| `node:stretch-slim`  |        63 | Latest official Node.js Docker image based on Debian (slim). |
| `node:alpine`        |        39 | Latest official Node.js Docker image based on Alpine. |
| `node:14.9.0`        |       345 | This  is identical to `node:14.9.0-stretch`, a specific version 14.9.0 on Debian stretch. |
| `node:14.9.0-alpine` |        39 | This is identical to `14.9.0-alpine` or `14.9.0-alpine3.11` (as Sep 5, 2020), a specific version 14.9.0 on Alpine. |

### Run as Non-Privileged User

In [the sample Dockerfile](Dockerfile), we are using `USER node` directly without first creating a user and group. This is because the base image `node` already created a user and a group called `node`.

### Clean Up devDependencies and NPM Cache

The `devDependencies` section of a `package.json` file allows us to define the npm packages needed for building and testing our applications. However, when releasing the application to production, we should remove the packages defined in `devDependencies`. Not only does it make the Docker image leaner but also more secure by excluding redundant dependencies at runtime, especially those that have known security vulnerabilities. Also, for a more consistent, repeatable install of the npm packages, it is recommended that we use `npm ci` instead of `npm install`. Read [here](https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci) to understand the difference between `npm ci` and `npm install`.
 
In addition, we clear the cache that NPM uses to verify the integrity of the npm packages for any subsequent changes made to the `node_modules` directory. Since Docker image is the final version of the application made for deployment to production, we typically include `npm clean cache --force` in every `npm install` statement in Docker. See [here](https://docs.npmjs.com/cli-commands/cache.html) for details on `npm clean cache`.

Include the following statement to install your npm packages in a Docker image for production. 

```dockerfile
RUN npm ci --production && npm cache clean --force
```

### Avoid npm start

Don't use `npm` to start the application as  `npm` doesn't pass any system signal to `node`.  Just invoke `node` directly. 

### Don't Use Process Managers

There's no need for process manager eg. pm2 or forever in a Node.js container. Docker or Kubernetes is the process or cluster manager.

## Reference

* [The Official Node.js Docker Image](https://hub.docker.com/_/node)
