# Service

Create services of the following types:

* ClusterIP - Expose a pod to other resources wihin the cluster.
* NodePort - Create a TCP port on the actual virtual machine, to which traffic from a pod will be routed. It also creates and assign a ClusterIP to the pod to so that it can be connected to the pod.
* LoadBalancer - Creates a load balancer that exposes a pod to the Internet. Note that a NodePort and a ClusterIP are automatically created and assigned to the pod.

## Setup

1. Create a [pod](../pod).   
1. Create a ClusterIP-based service.

   ```bash
   $ kubectl apply -f svc-clusterip.yaml
   ```
    
1. Test the service.

   ```bash
   $ kubectl get svc hello-service
   NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
   hello-svc-clusterip   ClusterIP   10.115.249.130   <none>        8080/TCP   43s
   $ kubectl proxy --port=8080
   $ curl http://localhost:8080/api/v1/namespaces/default/services/hello-service/proxy
   ```

1. Create a NodePort-based service.

   ```bash
   $ kubectl apply -f svc-nodeport.yaml
   ```

1. NodePort is assigned to the VM. So we need to access the VM using gcloud command (on GCP) or a bastion host (on AWS).

   ```bash
   $ gcloud compute ssh $(kubectl get pod hello-go -o json | jq -r '.spec.nodeName')
   vm > netstat -nap | grep 30000
   tcp6       0      0 :::30000                :::*                    LISTEN      -
   curl localhost:3000
   Hello, World!
   Server: hello-go
   ```

1. Create a LoadBalancer-based service

   ```bash
   $ kubectl apply -f svc-loadbalancer.yaml
   $ kubectl get svc hello-svc-loadbalancer
   NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)          AGE
   hello-svc-loadbalancer   LoadBalancer   10.115.251.73   34.83.252.220   8080:30190/TCP   54s
   ```
   
1. Test the service.

   ```bash
   $ curl "$(kubectl get svc hello-svc-loadbalancer -o json | jq -r '.status.loadBalancer.ingress[0].ip'):8080"
   ```

## Reference

* [Kubernetes: Service](https://kubernetes.io/docs/concepts/services-networking/service/)
