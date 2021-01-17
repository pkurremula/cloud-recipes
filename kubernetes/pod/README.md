# Pod

One of the simplest manifest file for creating a Pod is [pod.yaml](pod-simple.yaml). Other variants for creating the same pod but with additional configurations can be found in [variants](variants).

## Setup

1. Connect to a cluster and switch to the Kubernetes context.

   ```bash
   $ kubectl config use-context my-context
   ```

1. Create the pod.

   ```bash
   $ kubectl apply -f pod.yaml
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
