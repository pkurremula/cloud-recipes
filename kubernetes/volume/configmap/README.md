# Persistent Volume: ConfigMap

We use the `volumes` directive in docker-compose to mount files or directories in a container. For example, in the `docker/docker-compose.yaml` file, we tell docker-compose to mount `seed-data.js` as ``docker-entrypoint-initdb.d/seed-data.js` in the container.

To achieve this in Kubernetes, we would need to create a `ConfigMap` object and embed the js file in the `data` block of the `ConfigMap` object. And then use `volumes` and `volumeMounts` directives in the Pod object to inject the script to the Pod.

## Notes

* The `data` exposed in ConfigMap is text encoded in UTF-8. For other encoding, use `binaryData`

## Setup

1. Create the Pod and ConfigMap objects.

   ```bash
   $ kubectl create -f .
   pod/mongo-pod created
   configmap/mongo-seed-config created
   ```

1. Verify that the k8s objects are created.

   ```bash
   $ kubectl get po,cm
   NAME            READY   STATUS    RESTARTS   AGE
   pod/mongo-pod   1/1     Running   0          30s
   
   NAME                          DATA   AGE
   configmap/mongo-seed-config   1      30s
   ```

1. Verify that the script is injected, and the seed data loaded.

   ```bash
   $ # Connect to Mongo
   $ kubectl exec -it pod/mongo-pod -- mongo -u root -p password
   > use cloud-recipes
   > db.users.find()
   { "_id" : ObjectId("6006adf81fdac28471050719"), "username" : "admin", "email" : "superuser@example.com", "age" : 40, "createdAt" : ISODate("2021-01-19T09:27:55.200Z") }
   { "_id" : ObjectId("6006adf81fdac2847105071a"), "username" : "chan", "email" : "michael.chan@example.com", "age" : 24, "createdAt" : ISODate("2021-01-19T09:06:52.439Z") }
   { "_id" : ObjectId("6006adf81fdac2847105071b"), "username" : "john", "email" : "jonny@example.com", "age" : 31, "createdAt" : ISODate("2021-01-19T09:53:06.796Z") }
   ```

1. Tear down the objects.

   ```bash
   $ kubectl delete -f .
   ```
