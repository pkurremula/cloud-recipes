# Helm Chart

A simple Helm Chart to deploy the env-go application.

## Kubernetes

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

### Redeployment

1. New docker image has been pushed and we want to deploy the new version.

   ```bash
   $ docker push
   $ cd ../k8s
   $ kubectl rollout restart deployment/env-go
   ```

### Helm

Here are the steps to create a Helm chart from scratch.

1. Create a new helm chart.

   ```bash
   $ helm create chart
   ```

1. Edit the file `chart/values.yaml`. 
1. Move all the files in `chart/templates` out. Copy the Kubernetes manifest files in `k8s/*.yaml` to `chart/templates`.
1. Convert the yaml files you to templates.
1. Do a dry-run of the installation.

   ```bash
   $ helm install --dry-run --debug env-go ./chart --values ./chart/values.yaml
   ```

1. To install the application.

   ```bash
   $ helm install env-go ./chart --values ./chart/values.yaml
   ```
   
1. To roll out a new version of the application.

   ```bash
   $ helm upgrade env-go ./chart --values ./chart/values.yaml
   ```   
   
1. To uninstall the application.

   ```bash
   $ helm uninstall env-go
   ```
