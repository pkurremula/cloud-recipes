# Persistent Volume: Manual Storage

Use a manual Persistent Volume (PV) to reference a directory or file on a Node instance. Then use a Persistent Volume Claim (PVC) to attach that directory to a Pod. The data in the PV persists even after a Pod is deleted.

## Notes

* The `hostPath` is in the Node (in the Kubernetes cluster), not the local machine. See the bash snippet below for details.

## Setup

1. Create the Kubernetes objects.

   ```bash
   $ kubectl create -f .
   ```

1. Verify that the objects are created.

   ```bash
   $ kubectl get po,pv,pvc
   NAME            READY   STATUS    RESTARTS   AGE
   pod/mongo-pod   1/1     Running   0          7m5s
   
   NAME                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   REASON   AGE
   persistentvolume/mongo-pv   128Mi      RWO            Retain           Bound    default/mongo-pvc   manual                  7m5s
   
   NAME                              STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
   persistentvolumeclaim/mongo-pvc   Bound    mongo-pv   128Mi      RWO            manual         7m5s
   ```

1. SSH into the Node to examine the host directory. Assume that we are running `minikube`.

   ```bash
   $ minikube ssh
   $ docker@minikube:~$ cd /tmp/mongo/data
   $ docker@minikube:/tmp/mongo/data$ ls
     WiredTiger         _mdb_catalog.wt                       index-1--8063822321406782035.wt  mongod.lock
     WiredTiger.lock    collection-0--8063822321406782035.wt  index-3--8063822321406782035.wt  sizeStorer.wt
     WiredTiger.turtle  collection-2--8063822321406782035.wt  index-5--8063822321406782035.wt  storage.bson
     WiredTiger.wt      collection-4--8063822321406782035.wt  index-6--8063822321406782035.wt
     WiredTigerHS.wt    diagnostic.data                       journal
   ```

1. Connect to Mongo via the mongo shell. Insert a document to mongo. We just want to see if the data is persisted even after we delete the object.

   ```bash
   $ kubectl exec -it pod/mongo-pod -- mongo
   > db.users.find({username: 'admin'})
   > // Insert a user.
   > db.users.insertOne({username: 'admin', age: 40})
   {
       "acknowledged" : true,
       "insertedId" : ObjectId("6005f8529848fa63b6a0cbad")
   }
   > db.users.find({username: 'admin'})
   { "_id" : ObjectId("6005f8529848fa63b6a0cbad"), "username" : "admin", "age" : 40 }
   ```
   
1. Delete the Pod.

   ```bash
   $ kubectl delete -f pod.yaml
   ```
 
1. Create the Pod (again).

   ```bash
   $ kubectl create -f pod.yaml
   ``` 

1. Connect to mongo.

   ```bash
   $ kubectl exec -it pod/mongo-pod -- mongo
   > // The data should have persisted.
   > db.users.find({username: 'admin'})
   { "_id" : ObjectId("6006b7f0268c96b8ce961430"), "username" : "admin", "age" : 40 }
   ```
   
1. Delete the objects.

   ```bash
   $ kubectl delete pod/mongo-pod
   $ # Delete pvc
   $ kubectl delete pvc/mongo-pvc
   $ kubectl get po,pv,pvc
   ```
