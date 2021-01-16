# Env-Go Helm Chart

Here are a set of different Helm Charts for deploying a custom application called `env-go`.

## Project Layout

Here is the breakdown of the project. See sections below for further description.

* [Application source code](src) - The directory contains the Go source code of the application. It also includes the Dockerfile.
* [Kubernetes](k8s) - The directory contains the manifests to deploy the application using just Kubernetes.
* Helm - There are 2 Charts for deploying the app.
  * [Basic](basic) - Normal way to deploy the app with 2 replicas.
  * [Conditional](conditional) - The chart treats (hypothetically) the app as a master-slave setup where there can only be 1 master but multiple slaves and their confiugrations differ. Helm  allows us to embed some conditionals and logic into the templates.

## Kubernetes

### Deployment

Deploying the app by Kubernetes.

1. Set the current Kubernetes context.

   ```bash
   $ kubectl config use-context my-context
   my-context
   ```
   
1. Deploy the deployment and service.

   ```bash
   $ cd k8s
   $ kubectl apply -f deploy.yaml
   $ kubectl apply -f service.yaml
   ```

### Rollout

1. New docker image has been pushed and we want to deploy the new version.

   ```bash
   $ docker push
   $ cd ../k8s
   $ kubectl rollout restart deployment/env-go
   ```

## Helm

### Deployment

1. Set the current Kubernetes context.

   ```bash
   $ kubectl config use-context my-context
   my-context
   ```

1. To deploy the application to the cluster.

   ```bash
   $ helm install env-go-basic ./basic --values ./basic/values.yaml
   ```

1. Check to see if the application is deployed.

   ```bash
   $ kubectl get deployments
   NAME           READY   UP-TO-DATE   AVAILABLE   AGE
   env-go-basic   2/2     2            2           17s
   ```
   
1. Look at the services and see what is exposed to the network.

   ```bash
   $ kubectl get services                                    
     NAME           TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
     env-go-basic   LoadBalancer   10.99.136.116   localhost     80:30830/TCP   13m
   ```

1. Connect with the service.

   ```bash
   $ curl http://localhost/env
   {"addr":":8080","is_master":false,"is_worker":false}
   ```

### Rollout
   
1. To roll out a new version of the application.

   ```bash
   $ helm upgrade env-go-basic ./basic --values ./basic/values.yaml
   ```   
   
1. To uninstall the application.

   ```bash
   $ helm uninstall env-go-basic
   ```

## TO-DO

1. Helm pulls the image from a remote repository. So we need to build and push the Docker image to the repository before we can run Helm. Create a script that covers the complete workflow from build to deployment.
