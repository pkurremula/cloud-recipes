# Ingress

An Ingress is a Level 7 (HTTP) load balancer for a Kubernetes cluster.

Unlike other Kubernetes resources, the Ingress resource to work with different load balancers. We need an Ingress controller eg. nginx, AWS ALB, Google LoadBlalancer, Contour, etc. So you can't just create an Ingress object. There's additional work is needed to install (or set up) the Ingress controller. Here is a list of different [Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

This recipe will create an Ingress object using the Google LoadBalancer.

## Setup

1. Create a [pod](../pod).   
1. Create a [NodePort-based service](../service).
1. Create an Ingress.

   ```bash
   $ kubectl apply -f ingress-glb
   ```
   
1. Test the Ingress.

   ```bash
   $ curl "$(kubectl get ingress hello-ingress -o json | jq -r '.status.loadBalancer.ingress[0].ip')" 
   ```

## Reference

* [Kubernetes: Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
