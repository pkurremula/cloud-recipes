# Create Helm Chart

Here is a quick guide on creating your Helm Chart from scratch.

1. Create a new helm chart.

   ```bash
   $ helm create basic
   ```

1. Edit the file `basic/values.yaml`. 
1. Move all the files in `basic/templates` out. Copy the Kubernetes manifest files in `k8s/*.yaml` to `basic/templates`.
1. Convert the yaml files you to templates.
1. Do a dry-run of the installation.

   ```bash
   $ helm install --dry-run --debug env-go-basic ./basic --values ./basic/values.yaml
   ```

1. To install the application.

   ```bash
   $ helm install env-go-basic ./basic --values ./basic/values.yaml
   ```
   
1. To roll out a new version of the application.

   ```bash
   $ helm upgrade env-go-basic ./basic --values ./basic/values.yaml
   ```   
   
1. To uninstall the application.

   ```bash
   $ helm uninstall env-go-basic
   ```

