# Deployment

For production workload, it's recommended that we don't create a Pod object for deployment. Instead, deploy an application using the Deployment object as it is designed to running pods under proper supervision. With multiple pods created for an application, Deployment  creates another object ReplicaSet to supervise the replicas. 

## Setup

1. Connect to a cluster and switch to the Kubernetes context.

   ```bash
   $ kubectl config use-context my-context
   ```

1. Create the deployment.

   ```bash
   $ kubectl apply -f deployment.yaml
   ```

1. Check the deployment status.

   ```bash
   $ kubectl get pods --watch
   NAME                        READY   STATUS    RESTARTS   AGE
   hello-go-6bcd85fb79-5dbj2   0/1     Running   0          40s
   hello-go-6bcd85fb79-mfjr7   0/1     Running   0          40s
   hello-go-6bcd85fb79-mvdzz   0/1     Running   0          40s
   hello-go-6bcd85fb79-5dbj2   1/1     Running   0          65s
   hello-go-6bcd85fb79-mfjr7   1/1     Running   0          69s
   hello-go-6bcd85fb79-mvdzz   1/1     Running   0          70s
   ```
   
   One final check on the resources.
   
   ```bash
   $ kubectl get all
   NAME                            READY   STATUS    RESTARTS   AGE
   pod/hello-go-6bcd85fb79-5dbj2   0/1     Running   0          23s
   pod/hello-go-6bcd85fb79-mfjr7   0/1     Running   0          23s
   pod/hello-go-6bcd85fb79-mvdzz   0/1     Running   0          23s
   
   NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/hello-go   0/3     3            0           23s
   
   NAME                                  DESIRED   CURRENT   READY   AGE
   replicaset.apps/hello-go-6bcd85fb79   3         3         0       23s
   ```

1. Expose the deployment and test the application.

   ```bash
   $ kubectl expose deploy/hello-go --port=8080 --type=LoadBalancer
   ```
   
   Run curl a few times.
   
   ```bash
   $ curl http://localhost:8080
   Hello, World!
   Server: hello-go-6bcd85fb79-mfjr7
   Hello, World!
   Server: hello-go-6bcd85fb79-mvdzz
   ```

## Reference

* [Kubernetes: Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
