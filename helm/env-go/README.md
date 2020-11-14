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
