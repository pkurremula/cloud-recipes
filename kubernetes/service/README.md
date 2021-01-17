# Service

Create Services of the following types:

* **ClusterIP** - Expose a pod to other resources wihin the cluster.
* **NodePort** - Create a TCP port on the actual virtual machine, to which traffic from a pod will be routed. It also creates and assign a ClusterIP to the pod to so that it can be connected to the pod.
* **LoadBalancer** - Creates a load balancer that exposes a pod to the Internet. Note that a NodePort and a ClusterIP are automatically created and assigned to the pod.
* **Headless** - All the aforementioned service types involved some proxy or load balancing. However there are times when we just need to each pod communicate directly with another pod. Usually headless service is used in a database cluster or replica set that is deployed as a StatefulSet in Kubernetes. In this setting, we need to know the exact address of each instance - as opposed to a stateless (k8s) Deployment or ReplicaSet where we don't care which pod we connect to since they are all the same (and stateless).

## Setup

## Create a Service Using Kubectl Expose

We can run everything using kubectl.

```bash
$ kubectl run hello-go --image=cybersamx/hello-go
$ kubectl expose pod/hello-go --port=8080 --type=LoadBalancer
$ kubectl get all
NAME           READY   STATUS    RESTARTS   AGE
pod/hello-go   1/1     Running   0          2m10s

NAME                         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/hello-go             LoadBalancer   10.105.24.91    localhost     8080:31400/TCP   11s
$ curl http://localhost:8080
Hello, World!
Server: hello-go
```

## Create a Service Using Manifest Files

1. Create the `hello-go` pod from [here](../pod).

### ClusterIP Service
 
1. Create a ClusterIP Service.

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

### NodePort Service

1. Create a NodePort service.

   ```bash
   $ kubectl apply -f svc-nodeport.yaml
   ```

1. NodePort is assigned to the VM. So we need to access the VM using gcloud command (on GCP) or a bastion host (on AWS).

   ```bash
   $ gcloud compute ssh $(kubectl get pod hello-go -o json | jq -r '.spec.nodeName')
   vm > netstat -nap | grep 30000
   tcp6       0      0 :::30000                :::*                    LISTEN      -
   curl localhost:30000
   Hello, World!
   Server: hello-go
   ```

### LoadBalancer Service

1. Create a LoadBalancer service

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

### Headless Service

Headless service is a special ClusterIP service.

1. Create a headless service.

   ```bash
   $ kubectl apply -f svc-headless.yaml
   ```
    
1. Query the cluster for all running services and you will find that the headless service does not have a cluster IP. This makes sense as it's headless - meaning there's no proxy.

   ```bash
   $ kubectl get svc hello-service
   NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
   hello-svc-headless    ClusterIP   None             <none>        8080/TCP   30s
   $ kubectl proxy --port=8080
   $ curl http://localhost:8080/api/v1/namespaces/default/services/hello-service/proxy
   ```

1. To connect to the pod, we need to find out the IP address for the service by querying the internal DNS server. To do this, we run a shell session from within the cluster to access the DNS. Use [this image cybersamx/shell-tool](../../docker/shell-tool) or an image that has `dig` or `nslookup` and `curl` installed.

   ```bash
   $ kubectl run shell-tool --rm -it --image cybersamx/shell-tool -- /bin/bash
   # nslookup hello-svc-headless
   Server:         10.96.0.10
   Address:        10.96.0.10#53
   
   Name:   hello-svc-headless.default.svc.cluster.local
   Address: 10.1.0.9
   # curl http://10.1.0.9:8080
   Hello, World!
   Server: hello-go
   # exit
   pod "shell-tool" deleted
   ```
   
   > **Notes**
   >
   > The `hello-go` manifest creates 1 pod. If we have created a Deployment or ReplicaSet with a replica count of more than 1, `nslookup` will return a set of IP addresses matching all pod instances.

## Reference

* [Kubernetes: Service](https://kubernetes.io/docs/concepts/services-networking/service/)
