# Local Kubernetes Setup

Currently, this guide is for a local Mac setup.

## Setup

### Kubectl Installation

1. Use Homebrew to install kubectl.

   ```bash
   $ brew install kubernetes-cli
   $ # The following install the exact same program and version.
   $ brew install kubectl
   ```

1. Verify kubectl is installed.

   ```bash
   $ kubectl version
   ```

### Minikube Installation and Setup

1. Use Homebrew to install minikube.

   ```bash
   $ brew install minikube
   ```

1. Verify minikube is installed.

   ```bash
   $ minikube version
   minikube version: v1.16.0
   commit: 9f1e482427589ff8451c4723b6ba53bb9742fbb1
   ```

1. By default, Minikube runs on Docker for Desktop. Optionally you can run Minikube on Hyperkit (MacOS native hypervisor driver) or Virtualbox.

   ```bash
   $ # Optionally run minikube on hyperkit
   $ minikube config set driver hyperkit
   ```

1. Start Minikube.

   ```bash
   $ minikube start
   ```
   
1. Check that we are connected to the Minikube cluster.

   ```bash
   $ kubectl config get-contexts
   ```   

## Minikube Addons

### Monitoring

Normally, you would do the following to enable the `merics-server` on Minikube.

1. Monitoring in Minikube is disabled by default.

   ```bash
   $ kubectl top nodes
   error: Metrics API not available
   ```

1. Enable Monitoring of Minikube by adding metrics-server.

   ```bash
   $ minikube addons enable metrics-server
   ``` 
   
1. Verify that monitoring is enabled.

   ```bash
   $ kubectl top nodes
   NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
   minikube   168m         2%     688Mi           11% 
   ```

### Dashboard

1. Launch the dashboard.

   ```bash
   $ minikube dashboard
   ```

## Teardown

When we are done with Minikube, stop and remove the resources - after all we allocated CPU cores and memory to running the VM for the cluster.

```bash
$ minikube stop
$ minikube delete
```
