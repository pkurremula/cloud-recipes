# Helm

A handy reference and recipes on Helm.

## Guides and Docs

* [Helm Quickstart](docs/quickstart.md) - Install Helm and use it to install Helm Charts (packages).
* [Create Helm Chart](docs/create-helm-chart.md) - Roll out your own Helm Charts.

## Recipes

* [Env-Go](env-go) - Different Helm Charts for deploying a custom application.
  * [Kubernetes](env-go/k8s) - No Helm Chart, just plain Kubernetes manifest for the same deployment.
  * [Basic](env-go/basic) - Basic Helm Chart for deploying the custom app.
  * [Conditional](env-go/basic) - Helm Chart with logic that dynamically configures the setup an installation of the custom app.
