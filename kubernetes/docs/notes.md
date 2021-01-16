# Kubernetes Notes

## Setup

### Install kubectl

1. Using Homebrew

   ```bash
   $ brew install kubectl
   ```
   
1. If you have gcloud installed, you can install kubectl using gcloud.

   ```bash
   $ gcloud components install kubectl
   ```

## Kubernetes Cluster

You have basically 2 types of Kubernetes cluster:

* Local like Minikube, Docker Desktop, or Kind.
* Kubernetes as a service, like GKE (Google Cloud), EKS (AWS), or AKS (Microsoft Azure).

## Kubernetes Components

* Kubernetes Proxy - A proxy exists in each node to route network to service resources in the cluster.
* Kubernetes DNS - A naming and discovery component for the cluster.

## Kubectl

`Kubectl` is a tool on the client for managing a Kubernetes cluster. 

### Basic Commands

The `kubectl` command is organized in the following way:

```
kubectl <command> <resource-name> <object-name> <arguments>
```

For example:

```
kubectl get nodes docker-desktop -o json 
```

Kubernetes is an API that is resource-oriented, ie. RESTful. The core commands, the ones shown below, is designed for CRUD operations - they are akin to verbs in REST. 

| Kubectl Command   | Verb    |     
|-------------------|---------|
| `apply`           | Create  |
| `get`, `describe` | Read    |
| `apply`, `edit`   | Update  |
| `delete`          | Destroy |

Resources in Kubernetes are: pods, services, nodes, etc.
Objects in Kubernetes are the instances of the resource types.

### Other Commands

Here are the commands that are provide auxiliary functions and are outside the scope of CRUD.

| Kubectl Command   | Description    |     
|-------------------|----------------|
| `logs`            | See the logs. |
| `label`           | Label (tag) a resource. | 
| `exec`            | Execute a command in a container. |
| `attach`          | Attach to a process, so you get the outputs of a process but can also send inputs. |
| `top`             | See the cpu and memory utilization of the top n of resources. |
| `cp`              | Copy files from local machine or a container to a pod. |
| `port-forward`    | Establish a secure tunnel between local machine and a pod. |

### Namespace

Namespace is a grouping of different resources within a cluster. 

### Context

Use context to set a default cluster or namespace to allow us to connect to different Kubernetes cluster (remotely or locally) as well as to a different namespace.

```bash
$ # Set the context.
$ kubectl config set-context my-context --namespace=application
$ # Switch to the context.
$ kubectl config use-context my-context
$ # List of all contexts.
$ kubectl config get-contexts
CURRENT NAME            CLUSTER         AUTHINFO        NAMESPACE
*       docker-desktop  docker-desktop  docker-desktop
        my-gke          my-gke          my-gke                                  
        my-gke          my-gke          my-gke          monitoring
$ # What is the current context.
$ kubectl config current-context
my-context
$ # Detail dump of all configurations associated with the local kubectl.
$ kubectl config view
$ # Delete a context.
$ kubectl config unset contexts.my-context
```

To configure kubectl to connect to a cluster, we first need to fetch the credentials and configurations of the cluster and store them in `~/.kube/config` in the client. Let's suppose we are using GCP, you can the following commands to configure kubectl to connect to GKE.

```bash
$ gcloud container clusters create my-gke --num-nodes 1 --region=us-west1
$ gcloud container clusters get-credentials my-gke
$ kubectl config get-contexts
CURRENT NAME                           CLUSTER                        AUTHINFO                       NAMESPACE
*       gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke gke_<project>_<region>_dev-gke  
$ # The context given by gcloud is long. Optionally, make it shorter.
$ kubectl config rename-context gke_<project>_<region>_dev-gke dev-gke
```  

## Reference

* [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
