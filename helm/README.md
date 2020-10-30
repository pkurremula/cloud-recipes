# Helm Setup Guide

This guide shows how to set up Helm in a GKE cluster in Google Cloud. Also, this guide uses some (albeit minimal) security in the setup.

## Prerequisite

* Kubernetes version 1.6 and above
* Helm version 3 and above 

**Note**: Hem 3 is different from Helm 2.

Assumptions:

* GKE cluster running
* The local host is MacOS

Even though this guide makes opinionated assumptions about the k8s cluster being GKE and the local host being MacOS, the concepts can be applied to other platforms.

## Setup

1. Connect to GKE and set up a context.

   ```bash
   $ gcloud auth application-default login
   $ gcloud auth login
   $ gcloud config set project my-gcp-project
   $ gcloud container clusters get-credentials my-gke
   ```

   Or you if you have already set up the context, just navigate to the context.
   
   ```bash
   $ kubectl config set-context my-gke
   ```

1. Set the cluster to install Tiller.

   ```bash 
   $ kubectl config current-context
   my-gke
   ```
   
1. Install Helm

   ```bash
   $ brew install helm
   ```

1. Let's say we want to install redis to the cluster. Run this command.

   ```bash
   $ helm search hub redis
   URL                                                     CHART VERSION   APP VERSION     DESCRIPTION                                       
   https://hub.helm.sh/charts/drycc-canary/redis           1.0.0                           A Redis database for use inside a Kubernetes cl...
   https://hub.helm.sh/charts/choerodon/redis              0.2.5           0.2.5           redis for Choerodon                               
   https://hub.helm.sh/charts/drycc/redis                  1.1.0                           A Redis database for use inside a Kubernetes cl...
   https://hub.helm.sh/charts/wener/redis                  10.8.2          6.0.8           Open source, advanced key-value store. It is of...
   https://hub.helm.sh/charts/bitnami/redis                11.2.3          6.0.9           Open source, advanced key-value store. It is of...
   https://hub.helm.sh/charts/hephy/redis                  2.4.2                           A Redis database for use inside a Kubernetes cl...
   https://hub.helm.sh/charts/helm-incubator/redis...      0.5.0           4.0.12-alpine   A pure in-memory redis cache, using statefulset...
   https://hub.helm.sh/charts/inspur/redis-cluster         0.0.2           5.0.6           Highly available Kubernetes implementation of R...
   https://hub.helm.sh/charts/helm-stable/redis-ha         4.4.4           5.0.6           Highly available Kubernetes implementation of R...
   https://hub.helm.sh/charts/hkube/redis-ha               3.6.1005        5.0.5           Highly available Kubernetes implementation of R...
   https://hub.helm.sh/charts/dandydeveloper/redis-ha      4.10.2          6.0.7           Highly available Kubernetes implementation of R...
   https://hub.helm.sh/charts/softonic/redis-sharded       0.3.0           6.0.6           A Helm chart for sharded redis                    
   https://hub.helm.sh/charts/bitnami/redis-cluster        3.2.10          6.0.9           Open source, advanced key-value store. It is of...
   https://hub.helm.sh/charts/prometheus-community...      3.6.0           1.11.1          Prometheus exporter for Redis metrics             
   https://hub.helm.sh/charts/hmdmph/redis-pod-lab...      1.0.2           1.0.0           Labelling redis pods as master/slave periodical...
   https://hub.helm.sh/charts/wyrihaximusnet/redis...      1.0.1           v1.0.0          Redis Database Assignment Operator                
   https://hub.helm.sh/charts/pozetron/keydb               0.5.1           v5.3.3          A Helm chart for multimaster KeyDB optionally w...
   https://hub.helm.sh/charts/enapter/keydb                0.16.2          6.0.16          A Helm chart for KeyDB multimaster setup          
   https://hub.helm.sh/charts/helm-stable/sensu            0.2.3           0.28            Sensu monitoring framework backed by the Redis ...
   ```
   
   The command returns a list of charts matchin `redis` on Helm Hub.
   
1. We need to add a Helm repo before we can search for a Redis chart.

   ```bash
   $ helm repo add stable https://charts.helm.sh/stable 
   ```

1. Search for a Chart in the repo.

   ```bash
   $ # Return all charts.
   $ helm search repo stable
   $ # Search for a specific chart.
   $ helm search repo redis
   $ # Get the latest list of charts.
   $ helm repo update
   ```
   
1. Install the chart.

   ```bash
   $ # Install chart stable/redis as redis
   $ helm install redis stable/redis
   ```
   
   Sometimes chart get deprecated. So read the output. For `stable/redis`, it tells us to install `bitnami/redis`.
   
   ```bash
   $ helm repo add bitnami https://charts.bitnami.com/bitnami
   $ helm install redis bitnami/redis
   ```
   
1. Now check you k8s cluster.

   ```bash
   $ kubectl get pods
   NAME                       READY   STATUS             RESTARTS   AGE
   redis-master-0             1/1     Running            0          83s
   redis-slave-0              1/1     Running            0          83s
   redis-slave-1              1/1     Running            0          43s
   ```
