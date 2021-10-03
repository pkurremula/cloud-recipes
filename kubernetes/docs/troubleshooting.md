# Kubernetes Troubleshooting

Some notes on troubleshotting Kubernetes.

## Open a Shell in the Cluster to Diagnose Network Issues

Love [nicolaka/netshoot](https://hub.docker.com/r/nicolaka/netshoot) Docker image as the swiss army knife for network diagnosis. Simply spin up a shell container in your k8s cluster and run the tools available in that container.

```bash
$ kubectl config use-context mycluster
$ kubectl run myshell --rm -i --tty --image nicolaka/netshoot -- /bin/bash
bash-5.1#
```

## Attach a Shell to an Existing Container

Sometimes you just need to connect to the container running in a Kubernetes cluster to troubleshoot the application - just like connecting to a VM using ssh.

We can use the subcommand `exec` in kubectl to connecting a shell to a container, like running: `kubectl exec -i -t my-pod -- /bin/sh`. But `exec` only works for connecting to a pod. What if you have a deployment running in your cluster? Then you need to do the following:

1. Get the pods running in the cluster.

   ```bash
   $ kubectl get pod -n my-namespace
   NAME                     READY   STATUS    RESTARTS   AGE
   my-pod-bc69cfc6f-cx47k   2/2     Running   0          35h
   my-pod-bc69cfc6f-snnt7   2/2     Running   0          35h
   ```
   
1. If we have more than 1 container running in a pod, we also need specify which container we want to access. So we would need to probe the name of the container (unless you already know it).

   ```bash
   $ kc describe pods my-pod-bc69cfc6f-cx47k -n my-namespace
   ```
   
1. Now we can connect to the container. We assume that the container has a shell installed.

   ```bash
   $ kubectl exec -i -t my-pod-bc69cfc6f-cx47k -n my-namespace --container my-container -- /bin/sh
   ```
