# Pod

One of the simplest manifest file for creating a Pod is [pod.yaml](pod-simple.yaml).

> **Notes**
>
> For production workload, it's recommended that we don't create a Pod object for deployment. Instead, deploy an application using the Deployment object as it is designed to running pods under proper supervision.

## Setup

### Deploy with Kubectl Run

If it's a simple deployment, we can always deploy an image by running:

```bash
$ kubectl run hello-go --image=cybersamx/hello-go
```

### Deploy with a Manifest File

1. Connect to a cluster and switch to the Kubernetes context.

   ```bash
   $ kubectl config use-context my-context
   ```

1. Create the pod.

   ```bash
   $ kubectl apply -f pod-simple.yaml
   $ kubectl get pods                        
   NAME       READY   STATUS    RESTARTS   AGE
   hello-go   1/1     Running   0          11s
   $ kubectl port-forward hello-go 8080:8080
   Forwarding from 127.0.0.1:8080 -> 8080
   Forwarding from [::1]:8080 -> 8080
   ```

   On a separate shell, run the following:
   
   ```bash
   $ curl localhost:8080
   Hello, World!
   Server: hello-go
   ```

## Reference

* [Kubernetes: Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
