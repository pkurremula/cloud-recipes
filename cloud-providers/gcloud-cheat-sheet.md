# GCloud Cheat Sheet

## Install

Information is currently only for Mac.

1. Install gcloud via Homebrew.

   ```bash
   $ brew install google-cloud-sdk
   ```

1. Install optional gcloud components.

   ```bash
   $ gcloud components install
   $ gcloud components update
   ```

## Auth and Configuration

### Authentication

```bash
$ gcloud auth login
$ gcloud auth application-default login
$ gcloud auth print-access-token
```

Read [this Stackoverflow article](https://stackoverflow.com/questions/53306131/difference-between-gcloud-auth-application-default-login-and-gcloud-auth-logi/53307505) on the difference between `gcloud auth login` vs `gcloud auth application-default login`. Basically the former is for interactive use with `gcloud` and the latter is more for programmatic use with Google Cloud SDK.

### Configuration

Configuration Setup. For `gcloud` to work properly, we need to point it to an account, project, and zone/region.

```bash
$ gcloud config set account me@gmail.com
$ gcloud config set project my-project
$ gcloud config set compute/region us-west1
$ gcloud config set compute/zone us-west1-a
$ gcloud config get-value project
$ gcloud config get-value compute/zone
```

### Configuration Context
   
`gcloud` allows us to create and manage multiple configuration contexts.

```bash
$ gcloud config configurations list
$ gcloud config configuratiions create client-config
$ gcloud config configurations list
$ # Go thru the regular setup.
$ gcloud config set account other@gmail.com
$ gcloud config set project other-project
$ gcloud config set compute/zone us-west1-a
$ gcloud config configurations activate client-config
$ gcloud config configurations delete client-config
```

### Region and Zone Information

Read [GCP complete list of regions and zones](https://cloud.google.com/compute/docs/regions-zones). Or run the following commands:

```bash
$ # Return a full list of all regions.
$ gcloud compute regions list
$ # Return a full list of all zones.
$ gcloud compute zones list
$ # Return a list filtered by a region.
$ gcloud compute zones list --filter=region:us-west1
```

### Project Information

Getting project id and number

```bash
$ PROJECT_ID=$(gcloud config get-value project)
$ PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")
```

## Call API

1. We can also programmatically call Google Cloud via its REST API. Use `gcloud auth` to print the access token that we would use to access the API endpoint.

   ```bash
   $ curl "https://cloudbuild.googleapis.com/v1/projects/${PROJECT_ID}/builds/${CLOUD_BUILD_ID}" \
     -H "Authorization: Bearer $(gcloud auth application-default print-access-token)"
   ```

## IAM

### Service Accounts

Get service account associated withe current project.

```bash
$ gcloud iam service-accounts create cloudrun-pubsub-invoker --display-name 'Cloud Run pub/sub invoker SA'
$ gcloud iam service-accounts list
$ gcloud projects get-iam-policy duro-infra-services
$ export SA_EMAIL=cloud-run-pubsub-invoker-sa@duro-infra-services.iam.gserviceaccount.com
$ export PROJECT_ID=my-project
$ # Get the IAM policies associated with a SA. Must use --flatten for the --filter to work
$ gcloud projects get-iam-policy ${PROJECT_ID} --flatten="bindings[].members" --filter="bindings.members:serviceAccount:cloud-run-pubsub-invoker-sa@duro-infra-services.iam.gserviceaccount.com"
$ # Add a new role to the policy.
$ gcloud projects add-iam-policy-binding ${PROJECT_ID} --role roles/iam.serviceAccountActor --member serviceAccount:${SA_EMAIL}
```

### Roles

Get IAM roles

```bash
$ # List of all roles
$ gcloud iam roles list
$ # List of roles for a project
$ gcloud iam roles list --project ${PROJECT_ID}
```

## GCS

### Basics

Listing.

```bash
$ # List all buckets in the current project
$ gsutil ls
$ # List all files in the bucket
$ gsutil ls gs://${BUCKET_NAME}
$ # Show disk space/usage
$ gstuil du -h gs://${BUCKET_NAME}
```

Create and remove buckets.

```bash
$ # Create a bucket
$ gsutil mb gs://${BUCKET_NAME}
$ # Remove a bucket
$ gsuitl rb gs://${BUCKET_NAME}
```

### Folders and Files

```bash
$ # Copy local file my-file to the bucket
$ gsutil cp my-file gs://${BUCKET_NAME}
$ # Copy local folder my-folder to the bucket
$ gsutil cp my-folder gs://${BUCKET_NAME}
$ # Copy local file my-file to the bucket/folder - note the trailing / to designate a folder
$ gsutil cp my-file gs://${BUCKET_NAME}/my-folder/

$ gsutil mv my-file gs://${BUCKET_NAME}
$ gsutil rm gs://${BUCKET_NAME}/my-file
$ gsutil cat gs://${BUCKET_NAME}/my-file  # Display the content of the file
```

### IAM Association

Add IAM to a GCS bucket, use the following:
   
```bash
$ gsutil iam get gs://my-bucket
$ # Add service account
$ # ROLE = objectViewer
$ gsutil iam ch serviceAccount:${SA_EMAIL}:${ROLE} gs://${BUCKET_NAME}
```
